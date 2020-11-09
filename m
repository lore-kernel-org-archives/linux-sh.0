From: Rob Landley <rob@landley.net>
Date: Mon, 09 Nov 2020 08:15:12 +0000
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
Message-Id: <526461bb-4cb0-a5cc-b933-2d7b2a37bd5d@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
In-Reply-To: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/5/20 11:15 AM, Jens Axboe wrote:
> On 11/5/20 9:20 AM, John Paul Adrian Glaubitz wrote:
>> Hi Jens!
>>
>> On 11/5/20 5:17 PM, Jens Axboe wrote:
>>> Gentle nudge on this one.
>>
>> I can build- and boot-test on SH and IA64.
> 
> That'd be great, thanks!
> 
>> I assume Rich will be fine with the SH changes, not sure about the IA64 and Tony.
> 
> Let's add Tony - maybe he'll have a chance to take a look at the ia64 change.

It breaks my ARCH=sh j2_defconfig build:

arch/sh/kernel/signal_32.c: In function 'do_signal':
arch/sh/kernel/signal_32.c:469:6: error: 'ti_work' undeclared (first use in this
function)

Admittedly I'm testing a stack of 6 other patches at the same time:

[PATCH -next v2] sh: intc: Convert to DEFINE_SHOW_ATTRIBUTE.eml
[PATCH] sh: dma: fix kconfig dependency for G2_DMA.eml
[PATCH] sh: remove CONFIG_IDE from most defconfig.eml
[PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro.eml
[PATCH v1] sh: Drop ARCH_NR_GPIOS definition.eml
[PATCH v2 RESEND +TRIVIAL] arch_sh: hyphenate Non-Uniform in Kconfig prompt.eml

But this is the one I need to revert to get 5.10-rc3 to build, the rest compile.

Rob
