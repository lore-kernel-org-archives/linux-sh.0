From: phil.edworthy@renesas.com
Date: Wed, 24 Aug 2011 13:18:09 +0000
Subject: Re: [PATCH 2/2] sh: Add unaligned memory access for PC relative
Message-Id: <OF907479DA.05985FE9-ONC12578F6.00489D54-802578F6.004901EC@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1314028597-7612-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1314028597-7612-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> > This add unaligned memory access support for the following 
instructions:
> >   mov.w @(disp,PC),Rn
> >   mov.l @(disp,PC),Rn
> > 
> > These instructions are often used on SH2A toolchains.
> > 
> Looks good! Are there any other instruction pairs you've stumbled in to
> on the SH-2A side? The 32-bit instructions are still a largely 
unresolved
> issue, too.

Not so far, though I haven't run much yet. I'm still having some issues 
with the loader so it's difficult to be sure that these emulated 
instructions are correct...
Phil

