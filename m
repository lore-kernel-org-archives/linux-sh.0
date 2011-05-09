From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 May 2011 16:26:18 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Suspend-to-RAM support
Message-Id: <BANLkTi=9LoUhNGL5ukk09WCWSrjOAgZx7A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110428172328.3626.92816.sendpatchset@t400s>
In-Reply-To: <20110428172328.3626.92816.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, May 8, 2011 at 3:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sat, 7 May 2011, Rafael J. Wysocki wrote:
>
>> On Thursday, April 28, 2011, Magnus Damm wrote:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > This patch adds a simple Suspend-to-RAM implementation
>> > for SH-Mobile ARM. The struct shmobile_suspend_ops are
>> > kept global to allow cpu-specific code to override
>> > the callbacks if needed.
>> >
>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>> > ---
>>
>> I'd like to test some of my patches on top of this one, but I'm not sure
>> how to wake up the system from sleep.
>
> On mackerel you press one of the buttons on the edge of the board between
> the power-supply and the USB console connectors. On ap4evb it might be
> possible to use "phone" buttons on the board for that too, but you
> probably have to allow wake up somewhere, last I checked it didn't work
> out of the box.

Yeah, thanks Guennadi!

On Mackerel you can of course use the Androidish keypad to wake up,
but the touch panel worked as well last time i tested. Basically any
driver that supports wake-up should work.

/ magnus
