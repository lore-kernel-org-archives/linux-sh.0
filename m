From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 06 Aug 2015 00:43:37 +0000
Subject: Re: R-Car Gen3 VSP/DU work in progress
Message-Id: <3785009.kJTWmPSlky@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

The first working prototype of VSP+DU integration for Gen3 is available at

 	git://linuxtv.org/pinchartl/media.git drm/du/vsp1-kms/gen2

For background information please see the first mail in this thread (available 
at http://www.spinics.net/lists/linux-sh/msg43772.html).

The code currently targets the Koelsch board as a test environment as I don't 
have access to Gen3 hardware yet. No Gen3 code is thus available, this will be 
my next target.

Please note that this is work in progress. I will tag new versions (possibly 
using separate branches), but the code will be rebased. In particular Gen2-
specific testing code, including code in the rcar-du-drm driver, will likely 
be dropped after completing Gen3 support.

-- 
Regards,

Laurent Pinchart

