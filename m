From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 06:02:20 +0000
Subject: Re: [linux-pm] [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <aec7e5c30905272302w1539fd22sf38e4f513f2d3247@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 27, 2009 at 9:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 27, 2009 at 07:06:25PM +0900, Magnus Damm wrote:
>
>> These patches extend platform device and driver interfaces to
>> allow architectures to implement platform device runtime pm.
>
>> Have a look at the last patch for a SuperH mockup that shows how
>> it all fits together. We need this or a similar interface to be able
>> to enter deep sleep states on SuperH. I believe other architectures
>> have similar requirements.
>
> ARM definitely does. =A0The OMAP SoCs are probably furthest along in
> software support for this sort of functionality but it's pretty much
> standard for modern ARMs. =A0I'd CC in the ARM list but it's subscribers
> only, though the OMAP folks are also over on linux-omap@vger.kernel.org
> which isn't.

I'll include linux-omap next time. Thanks for your suggestion!

/ magnus
