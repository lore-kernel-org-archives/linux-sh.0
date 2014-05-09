From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 09 May 2014 11:50:00 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to R8A779[01] DT
Message-Id: <15728378.0mYCvNLXzQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 08 April 2014 18:35:55 Laurent Pinchart wrote:
> Hello,
> 
> This patch series adds VSP1 nodes to the R8A7790 and R8A7791 .dtsi files. It
> is based on top of the "[PATCH 0/2] Fix VSP1 clock names in r8a779[01]
> .dtsi" series that has been sent to the linux-sh mailing list, as well as
> the "[PATCH] v4l: vsp1: Remove unexisting rt clocks" patch and "[PATCH 0/6]
> VSP1 Blend/ROP Unit and DT support" series sent to the linux-media mailing
> list.
> 
> The VSP1 DT bindings are still pending an ack, please don't apply this
> series yet.

The DT bindings have been pulled into the media tree and will be merged in 
v3.16. Could you please merge these two patches in your tree ?

> Laurent Pinchart (2):
>   ARM: shmobile: r8a7790: Add VSP1 devices to DT
>   ARM: shmobile: r8a7791: Add VSP1 devices to DT
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 51 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7791.dtsi | 39 ++++++++++++++++++++++++++++++++
> 2 files changed, 90 insertions(+)

-- 
Regards,

Laurent Pinchart

