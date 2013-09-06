From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Sep 2013 16:27:22 +0000
Subject: Re: [PATCH 02/04] ARM: shmobile: r8a7791 SCIF support
Message-Id: <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034608.12546.79411.sendpatchset@w520>
In-Reply-To: <20130904034608.12546.79411.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 4, 2013 at 5:46 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
>
> Add SCIF serial port support to the r8a7791 SoC by
> adding platform devices for SCIFA0 -> SCIFA5 as well
> as SCIFB0 -> SCIFB2 and SCIF0 -> SCIF5 together with
> clock bindings. DT device description is excluded at
> this point since such bindings are still under
> development.

A good way to get started with clock bindings may be to
move the clocks to drivers/clk because in the neighboring
drivers over there are many good examples of how to do
this.

Again this looks like it is piling up more legacy clk
code instead of moving to the new frameworks.

Please include Mike Turquette on future postings of the
clk code, he's definately our best clock code reviewer.

Yours,
Linus Walleij
