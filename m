From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 01 Dec 2012 22:55:35 +0000
Subject: Re: [PATCH v2 00/77] SH pin control and GPIO rework with OF support
Message-Id: <CACRpkdbRDS27j85WHmGMtLrHHoW65o4ydfEiJBDLD5gxUpSHdQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 27, 2012 at 1:01 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Here's the second version of the SH pin control and GPIO rework patches. I've
> added OF support for PFC instantiation and GPIO mappings that was missing from
> v1. PINCTRL bindings are still missing and will come soon.

So I've tried the only way I could to review this by cloning your tree
and actually inspecting the end result ... overall it's looking very good!

Here are assorted comments:

- Some use of __devicexit/__devinit, this will be deleted in the v3.8
  merge window so just remove this everywhere.

- You're using the method to add ranges from the pinctrl side of
  things. This is basically deprecated with the changes to gpiolib
  I make in this merge window. If you study the way I changed
  the pinctrl-u300.c and pinctrl-coh901.c to switch the registration
  from being done in the pin controller to being done in the
  gpiolib part, you will get the picture. The big upside is that
  (A) makes the pin and GPIO references to the local GPIO
  chip and pin controller and (B) that this supports adding ranges
  from the device tree, which is probably what you want in the
  end...

- The above probably means you can get rid of
  sh_pfc_register_gpiochip() and decouple the pinctrl
  and gpiolib code like I did in my patch set
  (commit 8604ac34e in the pinctrl tree) and just
  initialize the GPIO with some module_init().
  But I might be wrong!

- sh_pfc_register_pinctrl() in pinctrl.c is using kzalloc/kfree,
  but since it has a struct sh_pfc, which contains a
  struct device *, I suspect you can use devm_kzalloc()
  and cut the kfree():s. This probably applies in more
  places in the driver.

- core.c contains pfc_ioremap() and pfc_iounmap()
  which actually seem to exist much due to the fact
  that devm_kzalloc() and devm_ioremap_nocache() did not
  exist at the time. By using devm_* helpers and
  maybe also inlining the code I think it'll look way
  smoother.

- sh_pfc.h contains this:
  typedef unsigned short pinmux_enum_t;
  typedef unsigned short pinmux_flag_t;
  But custom typedefs in the kernel is discouraged unless
  there is a good reason for. What about you search/replace
  this thing with u16 everywhere. I really like u16...
  I can see macros building up some gigantic bit pattern in
  these but in the end it's still just 16 unsigned bits.
  The name "pinmux_enum_t" is very dangerously
  close to the builting "enum" so it scares me a bit
  for that reason too.

- sf_pfc.h contains a number of structs which I just
  have no chance of understanding unless they are
  supplied with something real nice like kerneldoc,
  struct pinmux_gpio, pinmux_cfg_reg, pinmux_data_reg,
  pinmux_irq, pinmux_range and sh_pfc_soc_info all
  need some doc I think, I just don't understand these
  structs.

- Same goes for the helper macros.

- In core.h document struct pfc_window, i.e. what are
  these windows? What do we mean by a window?
  How many of them exist in a certain configuration
  typically? etc, stuff you want to know when reading
  the code.

- struct sh_pfc is however quite self-explanatory.

- The pfc-* drivers include things like:
  #include <cpu/sh7785.h>
  #include <mach/r8a7740.h>
  #include <mach/irqs.h>
  #include <mach/r8a7779.h>
  #include <mach/sh73a0.h>
  #include <mach/irqs.h>
  Why? Especially <mach/irqs.h> would be nice to
  get rid of, as it sort of defeats the idea of passing
  IRQs as resources or allocating them dynamically.
  In some cases it seems these includes are just
  surplus, so please look over this...

- This stuff in setup_data_regs():
  rp->reg_shadow = gpio_read_raw_reg(drp->mapped_reg,
                                                    drp->reg_width);
  You know, I think shadow registers is just another name
  for regmap-mmio. Please consult
  drivers/base/regmap/regmap-mmio.c and tell me if I'm
  wrong. It's not like I'm going to require you to convert this
  to regmap from day 1 if this is legacy stuff but it's probably
  the same thing.

- In core.c, gpio_read_raw_reg() and gpio_write_raw_reg()
  are looking like marshalling functions to me. This is also
  what regmap is about. Marshalling and caching/shadow.
  If you keep the functions as they are, atleast rename them
  to sh_pfc_* because the gpio_* namespace is for gpiolib.
  (There are a few other functions that need to be prefixed
  in that file by the way.)

- While keeping Magnus' and Paul's names as authors in the
  files it would be proper if you atleast add your own name since
  you've probably written most of the code in these files now.
  Also for MODULE_AUTHOR().

Let's have this patchset finished for v3.9 say? :-)

Yours,
Linus Walleij
