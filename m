From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 07:33:17 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva
Message-Id: <20130213073315.GA15587@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360689333-13525-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360689333-13525-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 12, 2013 at 04:53:51PM -0800, Kuninori Morimoto wrote:
> 
> Hi Guennadi
> 
> > When regulators are used with MMC devices, explicitly provided OCR masks
> > are ignored, they can be removed from platform data. Also switch SDHI0
> > from fixed regulator with hard-wired GPIO levels to a proper GPIO regulator
> > instance to enable dynamic voltage switching.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> 
> I got "checkpatch.pl" warning on this patch.
> I don't care so much about "Avoid CamelCase",
> but please fix "line over 80 characters" and "{" position.

Thanks Morimoto-san.

Guennadi I'm holding off on applying this for the above tweaks.
