From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Feb 2013 08:26:57 +0000
Subject: Re: [PATCH v3 1/3] serial: sh-sci: Add OF support
Message-Id: <CANqRtoRXjiX227Mop2ysGDij0F0W-c-_xq4UMn7K-Hhmg-e=4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
	<20130227080742.GB21690@linux-sh.org>
	<CANqRtoSDqm1VMZxxuPgnpNScfSVsozeS=_m0-1t6Z1w0vny7FA@mail.gmail.com>
	<20130227081954.GA30395@linux-sh.org>
In-Reply-To: <20130227081954.GA30395@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, "Simon Horman [Horms]" <horms@verge.net.au>

On Wed, Feb 27, 2013 at 5:19 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Feb 27, 2013 at 05:11:34PM +0900, Magnus Damm wrote:
>> On Wed, Feb 27, 2013 at 5:07 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Tue, Feb 26, 2013 at 11:03:26AM -0600, Bastian Hecht wrote:
>> >> We add the capabilty to probe Renesas SCI devices using Device Tree setup.
>> >>
>> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> >> ---
>> >> v3:
>> >> - add remaining register layouts to bindings
>> >> - remove register set mapping sci_regtype_modes[]
>> >> - adapt renesas,regtype probing
>> >>
>> >> - add enums SCBRR_ALGO_INVALID and SCBRR_NR_ALGOS
>> >> - check renesas,scbrr-algo-id boundaries using new enums
>> >>
>> >>  .../bindings/tty/serial/renesas,sci-serial.txt     |   53 ++++++++
>> >>  drivers/tty/serial/sh-sci.c                        |  126 +++++++++++++++++++-
>> >>  include/linux/serial_sci.h                         |    4 +
>> >>  3 files changed, 179 insertions(+), 4 deletions(-)
>> >>  create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
>> >>
>> > Looks good to me.
>> >
>> > Reviewed-by: Paul Mundt <lethal@linux-sh.org>
>>
>> Thanks. Do you intend to merge this yourself at some point, or do you
>> have some other preferred way to deal with this?
>>
> I can merge it if you like, but then obviously the ARM patches will have
> to wait until that part is upstream. I assumed you would want them all
> grouped together, at which point I don't mind if it goes through some
> other tree.

[Added Simon as CC]

My personal preference would be that you (Paul) merge this patch by yourself:
[PATCH v3 1/3] serial: sh-sci: Add OF support

I believe we can deal with the SoC bits easily afterwards. Simon may
however prefer to deal with it differently.

Simon, how do you prefer to handle merge of DT support for the SCIF driver?

Thanks,

/ magnus
