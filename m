From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 16 Aug 2020 16:38:58 +0000
Subject: Re: Ping: Pull Request for 5.9
Message-Id: <d31c8d5d-5489-2519-460d-d872c70f0309@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
In-Reply-To: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert!

On 8/16/20 10:34 AM, Geert Uytterhoeven wrote:
> On Sat, Aug 15, 2020 at 12:41 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> @Geert: What about that patch to fix the serial interface on LANDISK?
> 
> It's a fix for serial parity handling for SCIF, and thus not really needed for
> a serial console.    No need to worry, as it's already in.

Great. Then I hope we can work on the device tree stuff in the near future ;-).

My hope is that with device tree support in the kernel for SH, it might be easier
to re-add support for the NextVoD devices of which I have plenty of.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
