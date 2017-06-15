package com.company.pm.bpm;

import com.haulmont.bpm.web.controller.BpmFileDownloadController;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.core.global.FileLoader;
import com.haulmont.cuba.core.global.FileStorageException;
import com.haulmont.cuba.core.global.FileTypesHelper;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.core.sys.AppContext;
import com.haulmont.cuba.core.sys.SecurityContext;
import com.haulmont.cuba.security.global.UserSession;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

/**
 * Temporary fix for BPM issue if the application is deployed using Single WAR option.
 * Will be removed after fix in the platform.
 */
public class SingleWarBpmFileDownloadController extends BpmFileDownloadController {

    private final Logger log = LoggerFactory.getLogger(SingleWarBpmFileDownloadController.class);

    @Inject
    private FileLoader fileLoader;

    /**
     * Method is used by the BPMN modeler for extracting custom stencil icon
     */
    @Override
    @RequestMapping(value = "/modeler/icon", method = RequestMethod.GET)
    public ModelAndView download(HttpServletRequest request, HttpServletResponse response) throws IOException {
        UserSession userSession = getSession(request, response);
        if (userSession == null) {
            error(response);
            return null;
        }

        AppContext.setSecurityContext(new SecurityContext(userSession));
        try {
            UUID fileId;
            try {
                fileId = UUID.fromString(request.getParameter("f"));
            } catch (Exception e) {
                log.error(e.toString());
                error(response);
                return null;
            }

            FileDescriptor fd = dataService.load(new LoadContext<>(FileDescriptor.class).setId(fileId));
            if (fd == null) {
                log.warn("Unable to find file with id " + fileId);
                error(response);
                return null;
            }

            String fileName;
            try {
                fileName = URLEncoder.encode(fd.getName(), StandardCharsets.UTF_8.name());
            } catch (UnsupportedEncodingException e) {
                log.error(e.toString());
                error(response);
                return null;
            }

            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setHeader("Content-Type", getContentType(fd));
            response.setHeader("Pragma", "no-cache");

            boolean attach = Boolean.valueOf(request.getParameter("a"));
            response.setHeader("Content-Disposition", (attach ? "attachment" : "inline")
                    + "; filename=" + fileName);

            downloadFromMiddlewareAndWriteResponse(fd, response);

        } finally {
            AppContext.setSecurityContext(null);
        }
        return null;
    }

    private void downloadFromMiddlewareAndWriteResponse(FileDescriptor fd, HttpServletResponse response) throws IOException {
        ServletOutputStream os = response.getOutputStream();
        try (InputStream is = fileLoader.openStream(fd)) {
            IOUtils.copy(is, os);
            os.flush();
        } catch (FileStorageException e) {
            log.debug("Unable to download file: no available server URLs");
            error(response);
        }
    }

    protected String getContentType(FileDescriptor fd) {
        if (StringUtils.isEmpty(fd.getExtension())) {
            return FileTypesHelper.DEFAULT_MIME_TYPE;
        }

        return FileTypesHelper.getMIMEType("." + fd.getExtension().toLowerCase());
    }

    private void error(HttpServletResponse response) throws IOException {
        if (!response.isCommitted())
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}