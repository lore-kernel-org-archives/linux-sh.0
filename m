From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:22:38 +0000
Subject: Re: [PATCH v2 0/1] ARM: shmobile: add USB3.0 device node on r8a7791
Message-Id: <20141027002238.GF25692@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147382-4660-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414147382-4660-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 07:43:01PM +0900, Yoshihiro Shimoda wrote:
>  This patch is based on Simon's renesas.git branch and
> renesas-devel-20141024-v3.18-rc1 tag.
> Since koelsch and henninger doesn't have a USB3.0 connector,
> I submit a patch for r8a7791.dtsi only.

Thanks, I have queued this up.

> 
> Changes from v1:
>  - rebase the repository.
> 
> Yoshihiro Shimoda (1):
>   ARM: shmobile: r8a7791: add USB3.0 device node
> 
>  arch/arm/boot/dts/r8a7791.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> -- 
> 1.7.9.5
> 
