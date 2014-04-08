From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Apr 2014 00:39:27 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: correct renesas,gpios to renesas,groups in sd[02] pfc
Message-Id: <20140408003927.GD30496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1396898212-7078-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdW+ZD0r+W2BWw8Uusz_LYPmnrsX+Hk5wkvhiEf0f8u4cg@mail.gmail.com>
In-Reply-To: <CAMuHMdW+ZD0r+W2BWw8Uusz_LYPmnrsX+Hk5wkvhiEf0f8u4cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, magnus.damm@opensource.se, Rob Taylor <rob.taylor@codethink.co.uk>

On Mon, Apr 07, 2014 at 10:35:12PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 7, 2014 at 9:16 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > From: Rob Taylor <rob.taylor@codethink.co.uk>
> >
> > Fix probable typo of renesas,groups in the lager dt. The kernel has no
> > renesas,gpios but this should match renesas,groups.
> >
> > Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
> 
> Thanks, nice catch!
> 
> > [ben.dooks@codethink.co.uk: fixup description]
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, I will queue this up as a fix for v3.15.
