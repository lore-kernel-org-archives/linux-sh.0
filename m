From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 25 Feb 2015 20:58:42 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: r8a7791: Remove non existing GPIO pins
Message-Id: <54EE3782.5040108@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424115661-21928-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1424115661-21928-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424115661-21928-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-gpio@vger.kernel.org

On 02/16/2015 10:41 PM, Laurent Pinchart wrote:

> GPIO banks 1 and 7 are missing pins 26 to 31. Remove them.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

    This patch breaks the boot as well, please don't apply it yet. The same 
about R8A7790 patch. We're thinking about a proper fix...

WBR, Sergei

