From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Sep 2013 16:21:23 +0000
Subject: Re: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
Message-Id: <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
In-Reply-To: <20130904034557.12546.97503.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 4, 2013 at 5:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
(...)
>  arch/arm/mach-shmobile/clock-r8a7791.c        |  198 +++++++++++++++++++++++++

So what about starting afresh by letting this new SoC use the
generic clk framework in drivers/clk from day one instead of
adding another chunk of custom clk code to the kernel?

(There may be reasons for this, but I have to ask the
inevitable question.)

Yours,
Linus Walleij
