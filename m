From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 02 Apr 2015 02:09:59 +0000
Subject: Re: hardcoding of plane ID's to hardware planes
Message-Id: <1702225.SiyoLnNE83@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Devendra,

On Wednesday 01 April 2015 10:48:57 Devendra Talegaonkar wrote:
> Hi Laurent,
> 
> On R-car platform, is there any way to map plane ID to hardware plane number
> at the time of initialization. It seems DRM/KMS driver maps user plane ID to
> first available hardware plane.
> 
> If suppose, plane ID's are from 10 to 15 (for 6 planes) and there are total
> 6 hardware planes then is it possible to achieve following scenario:
> 
> Plane ID 10 <-> hardware plane 1
> Plane ID 11 <-> hardware plane 2
> Plane ID 12 <-> hardware plane 3
> Plane ID 13 <-> hardware plane 4
> Plane ID 14 <-> hardware plane 5
> Plane ID 15 <-> hardware plane 6
> 
> We are not using any layer manager or X11 as a server.

First of all, please note that the KMS plane ID is dynamic and isn't 
guaranteed to be stable with kernel upgrades, or possibly even across reboots.

The reason for dynamic allocation of hardware planes is that planar YUV 
formats (NV12, NV21 and NV16) require two hardware planes, while all other 
formats use a single hardware plane. It's thus not possible to map KMS planes 
to hardware planes at initialization time as the driver can't know what 
formats to expect for the planes.

-- 
Regards,

Laurent Pinchart

