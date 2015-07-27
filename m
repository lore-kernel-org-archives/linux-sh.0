From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Jul 2015 12:52:29 +0000
Subject: Re: [PATCH v2] gpio: rcar: Add r8a7795 (R-Car H3) support
Message-Id: <CACRpkdY0u69L9dHhRFE4WqcAvMsxhi6=LDh5UQgY5uFBqcu4+Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437469730-16460-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437469730-16460-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 21, 2015 at 11:08 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:

> R-Car Gen3's GPIO blocks are identical to Gen2's in every respect.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> This still recycles the Gen2 structure, but explains why.  That seems
> better to me than having the same data twice.
>
> Changes since v1:
> - added comment explaining the use of Gen2 info on Gen3

Patch applied with the ACKs.

Yours,
Linus Walleij
