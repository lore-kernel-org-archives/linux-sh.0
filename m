From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Feb 2013 19:46:18 +0000
Subject: Re: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
Message-Id: <CACRpkdaa285aBN-LWD2wBx3Z5CONZU5zqWEqmMMhjXyMUJNdfw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130214122347.20778.10789.sendpatchset@w520>
In-Reply-To: <20130214122347.20778.10789.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 1:23 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Fix sizeof() usage in sh-pfc/core.c to allocate space
> for the full data structure instead of a pointer.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
