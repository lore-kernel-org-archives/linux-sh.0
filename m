From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Mar 2013 10:23:43 +0000
Subject: Re: [PATCH 02/02] sh-pfc: Add r8a73a4 GPIO IRQ support
Message-Id: <CACRpkdbQbn4SNPY9UBZx=aShb5kyKP8D1v2LOLUwKrU1A8QQOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130318145049.26761.35712.sendpatchset@w520>
In-Reply-To: <20130318145049.26761.35712.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 18, 2013 at 3:50 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Add GPIO -> IRQ mappings to the PFC table for
> the r8a73a4 SoC. Requires the IRQs to be mapped
> at a fixed location. The actual IRQs are not
> handled by the PFC, instead IRQC is used.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This will go in with Simon's enormous patch queue I guess?

Yours,
Linus Walleij
