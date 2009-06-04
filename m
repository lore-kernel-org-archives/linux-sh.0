From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 10:03:50 +0000
Subject: Re: [linux-pm] [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <aec7e5c30906040303v172708bela84bfcb508d4abea@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Pavel!

On Wed, Jun 3, 2009 at 6:37 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > In the process of discussing a similar interface for OMAP, we dicussed
>> > that having 3 states would be more useful. =A0Specifically, and
>> > _enable(), _idle() and _disable() hook. =A0The _enable() and _idle()
>> > hooks being exactly what you proposed above, but with the addition of
>> > a _disable() hook which says not only can the device go idle, but that
>> > the driver is really finished with the device. =A0In this case, more
>> > aggresive PM measures could be taken, such as turning of regulators
>> > that may have long latencies that may not be appropriate to turn off
>> > in idle.
>>
>> Hm.. I wonder when the driver is really finished with the device
>> though. Only when the module is unloaded? If so then we could deal
>> with the hard disable using platform bus notifiers (like in [04/04]).
>
> I'd guess that they call disable() when /dev node is closed... and
> idle() when device is opened but inactive.

But the time from close() to next open() is work load dependent. So
the difference between _disable() and _idle() is pretty fuzzy in my
opinion. I'm trying to think of a case where hard _disable() is
needed, but nothing comes to mind.

In my mind a single disable()/idle() function together with latency
information is enough. It covers the entire range from _idle() to hard
_disable().

/ magnus
