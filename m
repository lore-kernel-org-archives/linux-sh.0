From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 01 Apr 2013 02:31:49 +0000
Subject: [INFO] R-Car DU DRM driver testing
Message-Id: <1689455.mcxOzcvm4g@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello everybody,

I've compiled instructions on how to use the modetest and dmabuf-sharing test 
tools with the R-Car DU DRM driver. In case someone would be interested in 
testing the driver, here they are.

The modetest tool is found in the libdrm repository. You can fetch the latest 
upstream version from

	git://anongit.freedesktop.org/mesa/drm master

and apply the "[PATCH v4 00/21] modetest enhancements" patch series posted on 
the dri-devel mailing list. Alternatively, you can get the patches from

	git-ideasonboard@git.ideasonboard.com:renesas/drm.git master

The tool is in the tests/modetest directory.

The dmabuf-sharing tool is found in the Samsung public-apps repository. You 
can fetch the latest version from

	git://git.infradead.org/users/kmpark/public-apps master

The tool is in the v4l2-drm-example directory.


Layer Priority
--------------

Layers priority is configured through the layer zpos property. The property 
takes an integer value between 1 and 7 inclusive. Layers with a higher zpos 
value are displayed on top of layers with a lower zpos value. If two layers 
have the same zpos value, the layer with the highest ID will be displayed on 
top.

# ./modetest -M rcar-du -s 9:1024x768@AR24 -d \
        -P '6:(200,200)/400x300@AR24' \
        -P '6:(300,300)/400x300@AR24' &
setting mode 1024x768@AR24 on connectors 9, crtc 6
testing 400x300@AR24 overlay plane 12
testing 400x300@AR24 overlay plane 13

# ./modetest -M rcar-du -w 12:zpos:2

Layer Opacity
-------------

Layer-wide alpha value is only supported for layers in the XRGB1555 format. It 
is configured through the layer alpha property.

# ./modetest -M rcar-du -s 9:1024x768@AR24 -d \
        -P '6:(200,200)/400x300@XR15' \
        -P '6:(300,300)/400x300@XR15' &
setting mode 1024x768@AR24 on connectors 9, crtc 6
testing 400x300@AR24 overlay plane 12
testing 400x300@AR24 overlay plane 13

# ./modetest -M rcar-du -w 13:alpha:128

Color Keying
------------

Color keying is configured through the layer colorkey property. The color key 
is expressed as an RGB888 triplet stored in a 32-bit integer in XRGB8888 
format. Bit 24 is used as a flag to disable (0) or enable color keying (1).

# ./modetest -M rcar-du -s 9:1024x768@AR24 -d \
        -P '6:(200,200)/400x300@XR15' \
        -P '6:(300,300)/400x300@XR15' &

./modetest -M rcar-du -w 12:colorkey:17436960

Dual Output (two CRTCs)
-----------------------

# ./modetest -M rcar-du -s 9:1024x768@AR24 -d \
        -P '6:(200,200)/400x300@AR24' &
setting mode 1024x768@AR24 on connectors 9, crtc 6
testing 400x300@AR24 overlay plane 12

# ./modetest -M rcar-du -s 11:1024x768@AR24 \
        -P '7:(300,300)/400x300@AR24'
setting mode 1024x768@AR24 on connectors 11, crtc 7
testing 400x300@AR24 overlay plane 13

Dual Output (cloned)
--------------------

# ./modetest -M rcar-du -s 9,11:1024x768@AR24 -d \
        -P '6:(200,200)/400x300@AR24'
setting mode 1024x768@AR24 on connectors 9, 11, crtc 6
testing 400x300@AR24 overlay plane 12

DMABUF
------

To test DMABUF support you will first need to load the vivi (virtual video) 
V4L2 driver. You can then test the R-Car DU DRM driver DMABUF exporter role 
with the following commands. The importer role can't be tested with the vivi 
driver.

# ./modetest -M rcar-du -s 9:1024x768@AR24 -d &
setting mode 1024x768@AR24 on connectors 9, crtc 6

# ./dmabuf-sharing -i /dev/video0 -f YUYV -S 640,480 \
        -M rcar-du -p 9:6 -F YUYV -t 640,480@192,144 -b 2
G_FMT(start): width = 640, height = 480, 4cc = YUYV
G_FMT(final): width = 640, height = 480, 4cc = YUYV
dbuf_fd = 5
dbuf_fd = 6
buffers ready

-- 
Regards,

Laurent Pinchart

