From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 03 Dec 2013 09:39:00 +0000
Subject: Re: [PATCH 0/2] sh-pfc: Fix pin bias setup
Message-Id: <CACRpkdZN-qQqsQ96sdkCUQsQXu=5skXfWWXKh5qrz-TLjf8iyA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 28, 2013 at 4:20 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> These two patches fix typos in the pin bias setup code for r8a7740 and sh7372
> that resulted in the incorrect register being written when configuring pull-ups
> and pull-downs.

Both applied to the pinctrl tree for fixes.

Yours,
Linus Walleij
