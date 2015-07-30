From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 30 Jul 2015 13:50:32 +0000
Subject: R-Car Gen3 VSP/DU work in progress
Message-Id: <1788822.6tuLoCYX5D@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

In order to allow early feedback on the API and implementation, I've pushed my 
work in progress branch for R-Car Gen3 DU support to

	git://linuxtv.org/pinchartl/media.git drm/du/vsp1-kms

Compared to the 2nd generation, the Gen3 DU has lost the ability to read 
directly from memory. It must instead be fed by a VSP instance dedicated to 
display composition.

The direct hardware link between the VSP and the DU was already available in 
Gen2 but using the VSP wasn't mandatory. For that reason, and as the VSP is a 
memory-to-memory video processing device in the general case, the VSP driver 
has been implemented using the V4L2 API and the DU driver using the DRM/KMS 
API. Applications have to use both APIs if they want to use the VSP with the 
DU.

As the Gen3 DU has no composition capability, forcing all display applications 
to use both APIs increases userspace complexity beyond what was considered 
acceptable. We have thus decided to drive the Gen3 VSP DU from the DU driver. 
However, to avoid code duplication, the existing VSP driver should still be 
used, without exposing the full V4L2 API.

The work in progress code reworks the VSP driver to make the V4L2 userspace 
API optional while still modeling the device using V4L2 objects inside the 
kernel. It also creates an high-lever in-kernel API exposed by the VSP driver 
to be used by the DU driver to control the VSP.

On the DU side, a new provider of planes has been added that delegates plane 
control to the VSP.

I've targeted the code at Gen2 hardware for testing purpose. I will still need 
to implement support for the differences between Gen2 and Gen3 registers for 
the VSP and DU once after validating the operation  using Gen2.

The code is not fully functional yet. In particular the vsp1-drm.c 
implementation isn't complete. I'll keep working on that over the weekend.

-- 
Regards,

Laurent Pinchart

