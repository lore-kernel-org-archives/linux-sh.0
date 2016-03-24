From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Mar 2016 21:18:56 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <CANqRtoT8C1iaWb5T+z8KXaJgvQMQ1WLPVAaKX4VJCc1J+CDiSg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 24, 2016 at 6:01 PM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 03/24/2016 09:50 AM, Magnus Damm wrote:
>> I recall hearing that Dreamcast hardware was historically used for
>> some SH development. Can't be that difficult to find such hardware,
>> however I highly doubt that the boot process is very convenient.
>> Hardware wise Dreamcast probably contains something like sh775x so it
>> should be similar to whatever is in QEMU.
>
> The Dreamcast has just 16 MiB of RAM. On the other hand, the LANDISK
> NAS device I have acquired for Rich in Japan comes with 64 MiB RAM
> and a SH7751 CPU running at 266 MHz. And people have used these devices
> in the past to run Debian.

Indeed 64 MiB is better than 16MiB. It is also still simple to handle
from a software perspective with the fixed virtual-to-physical memory
windows used by the SH architecture. For more than 256 MiB of RAM some
32-bit extensions were added, perhaps combined with the PMB hardware
unit unless I remember incorrectly. Those 32-bit extensions are not
available on older SoCs like sh7751 but on later generations like
sh7785 and probably sh7786 as well.

/ magnus
