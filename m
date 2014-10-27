From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:22:49 +0000
Subject: Re: [PATCH v5 0/2] Add HS-USB device tree support for R8A7790/Lager board
Message-Id: <20141027002249.GG25692@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147474-2348-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414147474-2348-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Oct 24, 2014 at 07:44:32PM +0900, Yoshihiro Shimoda wrote:
> Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20141024-v3.18-rc1' tag. Here we add the HS-USB device tree
> support on the R8A7790/Lager reference board. The patchset requires the USB PHY
> driver (already merged by Kishon and Greg) and the generic PHY support patches
> for the HS-USB driver posted by Yoshihiro Shimoda in order to work...

Thanks, I have queued these up.

> 
> Changes from v4:
>  - rebase the repository.
> 
> Yoshihiro Shimoda (2):
>   ARM: shmobile: r8a7790: add HS-USB device node
>   ARM: shmobile: lager: enable HS-USB
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |   12 ++++++++++++
>  arch/arm/boot/dts/r8a7790.dtsi      |   11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> -- 
> 1.7.9.5
> 
