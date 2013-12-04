From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 04 Dec 2013 01:06:29 +0000
Subject: Re: [PATCH 2/2] sh-pfc: Fix PINMUX_GPIO macro
Message-Id: <1840201.fMSxrYimbU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Tuesday 03 December 2013 10:34:36 Linus Walleij wrote:
> On Tue, Nov 26, 2013 at 2:45 AM, Laurent Pinchart wrote:
> > Commit 7cbb0e55e27e ("sh-pfc: Don't duplicate argument to PINMUX_GPIO
> > macro") erronesouly modified the PINMUX_GPIO macro in a way that
> > resulted in all pins being named "name". Fix the macro to name the pins
> > correctly.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Or is this a regression I should apply for fixes?

The problem has been introduced in v3.12. It could be sent as a bug fix to 
v3.13 and CC'ed to stable. If you do so, please let me know and I'll remove 
the patch from my pull request.

-- 
Regards,

Laurent Pinchart

