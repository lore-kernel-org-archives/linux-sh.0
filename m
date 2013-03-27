From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 08:48:27 +0000
Subject: Re: [PATCH 00/13 v2] sh-pfc: Initial r8a73a4 PFC support
Message-Id: <CANqRtoSOQrZuDD9hzce-Xat5L4e4v16uO9B5Qw2mCXe6hiOXGA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326134939.31366.42030.sendpatchset@w520>
In-Reply-To: <20130326134939.31366.42030.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 1:56 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Mar 26, 2013 at 10:49:39PM +0900, Magnus Damm wrote:
>> sh-pfc: Initial r8a73a4 PFC support (V2)
>>
>> [PATCH 01/13] sh-pfc: Add r8a73a4 pinmux support
>> [PATCH 02/13] sh-pfc: r8a73a4: Support sparse GPIO numbers
>> [PATCH 03/13 v2] sh-pfc: r8a73a4: GPIO IRQ support
>> [PATCH 04/13] sh-pfc: r8a73a4: Add bias (pull-up/down) pinconf support
>> [PATCH 05/13] sh-pfc: r8a73a4: Add SCIF pin groups and functions
>> [PATCH 06/13] sh-pfc: r8a73a4: Add IRQC pin groups and functions
>> [PATCH 07/13] sh-pfc: r8a73a4: Remove SCIF function GPIOS
>> [PATCH 08/13] sh-pfc: r8a73a4: Remove IRQC function GPIOS
>> [PATCH 09/13] ARM: shmobile: r8a73a4: Remove SCIF function GPIOs
>> [PATCH 10/13] ARM: shmobile: r8a73a4: Remove IRQC function GPIOs
>> [PATCH 11/13] sh-pfc: r8a73a4: Remove function GPIOs
>> [PATCH 12/13] ARM: shmobile: r8a73a4: Remove all GPIO enums
>> [PATCH 13/13] sh-pfc: r8a73a4: Remove unused GPIO bias data
>>
>> This series is V2 of initial PFC support for the r8a73a4 SoC.
>> The patches add a regular old-style GPIO function controller
>> and makes it partially converted over to PINCTRL for SCIF
>> and IRQC that are tied up on the APE6EVM board. The final
>> patches remove the GPIO function support, so when new drivers
>> for r8a73a4 are added then PINCTRL support has to be included.
>
> Hi Magnus,
>
> I apologise if the information is obvious or available elsewhere,
> but could you let me know a bit about the dependencies for this series.
>
> I am assuming it depends on:
>
> [PATCH 00/03 v3] ARM: shmobile: r8a73a4 APE6EVM board support
> [PATCH/RFC 00/12] Split PFC and GPIO for R8A7779

Hi Simon,

Thanks for your email. It looks like you estimated the worst-case
dependencies. =)

Fortunately, for r8a73a4 (APE6) there is no separate GPIO controller.
So regular PFC without any special dependencies is enough. This means
that the r8a7779 patches are not needed for r8a73a4. However, to fully
support r8a7790 (R-Car H2) we need to follow the same pattern as
r8a7779. The automotive SoCs seem to come with a separate GPIO
controller.

So based on that the following patches should be enough for merging:

 Written against renesas-next-20130321 in renesas.git
 Requires "r8a73a4.h" provided by
  [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V3

The above r8a73a4 SoC V3 series also requires the following patch:
[PATCH/RFC] ARM: shmobile: Disallow PINCTRL without GPIOLIB

To actually use this code you also need board code provided by a
separate patch series.

Thanks,

/ magnus
