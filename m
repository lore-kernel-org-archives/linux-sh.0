From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Apr 2013 09:13:56 +0000
Subject: Re: [PATCH 1/4] sh-pfc: Add support for SoC-specific initialization
Message-Id: <CACRpkdZZ3QjHiNBKW=9tvQapv+KhLZG5Faj6DoyhmMowYbRXKw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366672585-9098-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366672585-9098-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 23, 2013 at 1:16 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Add two optional init and cleanup SoC operations and call them from the
> core at probe and remove time.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Isn't it more kernel-like to call this function pair init/exit rather
than init/cleanup?

Yours,
Linus Walleij
