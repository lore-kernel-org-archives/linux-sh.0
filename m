From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Sep 2015 16:04:46 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <CANqRtoRs=f=07B=HSLCVg5G4rnhxj6Heod+spYwxHiKFLZqFWg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
	<5464456.UnsMOS3MTx@avalon>
	<20150903204000.GB1574@katana>
	<CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
	<20150905073143.GA1616@katana>
In-Reply-To: <20150905073143.GA1616@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

On Sat, Sep 5, 2015 at 4:31 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Sep 04, 2015 at 01:33:39PM +0900, Magnus Damm wrote:
>> Hi Wolfram,
>>
>> On Fri, Sep 4, 2015 at 5:40 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >
>> >> > So I refactored the driver to setup new messages in interrupt context, too.
>> >> > This avoids the race for b) because we are now setting up the new message
>> >> > before we release the i2c bus clock (before we released the clock and set up
>> >> > the message in process context).
>> >>
>> >> Could this fix the HDMI EDID read issue on Koelsch ?
>> >
>> > I surely hope so. I can't test because I don't have Koelsch.
>>
>> FYI, I have enabled Koelsch remote access on port 8001 if you want to
>> give it a shot!
>
> Thanks! Is there a HDMI monitor connected?

Yes, now a HD-ready TV is hooked up. It should give you something over
EDID. Let me know when you're done and I'll move things back.

Cheers,

/ magnus
