From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:22:58 +0000
Subject: Re: [PATCH v4 0/3] HS-USB device tree support for R8A7791/Koelsch/Henninger board
Message-Id: <20141027002258.GH25692@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147508-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414147508-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 07:45:05PM +0900, Yoshihiro Shimoda wrote:
>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20141024-v3.18-rc1' tag. Here we add the HS-USB device tree
> support on the R8A7791/Koelsch/Henninger reference boards. The patchset
> requires the USB PHY driver (already merged by Kishon and Greg) and the
> generic PHY support patches for the HS-USB driver posted by Yoshihiro Shimoda
> in order to work...
> 
> Changes from v3:
>  - rebase the repository.

Thanks, I have queued these up.

> 
> Yoshihiro Shimoda (3):
>   ARM: shmobile: r8a7791: add HS-USB device node
>   ARM: shmobile: koelsch: enable HS-USB
>   ARM: shmobile: henninger: enable HS-USB
> 
>  arch/arm/boot/dts/r8a7791-henninger.dts |    7 +++++++
>  arch/arm/boot/dts/r8a7791-koelsch.dts   |    7 +++++++
>  arch/arm/boot/dts/r8a7791.dtsi          |   11 +++++++++++
>  3 files changed, 25 insertions(+)
> 
> -- 
> 1.7.9.5
> 
