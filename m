From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Oct 2014 07:42:39 +0000
Subject: Re: [PATCH v2] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Message-Id: <CANqRtoTOehh=9kTmVnLBDCR4czO5ehRhaR10Um0vx0DA=wi5Bw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide@vger.kernel.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>, SH-Linux <linux-sh@vger.kernel.org>

On Fri, Oct 24, 2014 at 11:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> controller needs to be run with DIPM disabled.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v2
> * Handle ES1 in sata_rcar_init_controller()

This version looks fine to me. Thanks!

/ magnus
