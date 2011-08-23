From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Aug 2011 10:42:17 +0000
Subject: Re: [PATCH 2/2] sh: Add unaligned memory access for PC relative intructions
Message-Id: <20110823104217.GB26391@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1314028597-7612-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1314028597-7612-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 22, 2011 at 04:56:37PM +0100, Phil Edworthy wrote:
> This add unaligned memory access support for the following instructions:
>   mov.w @(disp,PC),Rn
>   mov.l @(disp,PC),Rn
> 
> These instructions are often used on SH2A toolchains.
> 
Looks good! Are there any other instruction pairs you've stumbled in to
on the SH-2A side? The 32-bit instructions are still a largely unresolved
issue, too.
