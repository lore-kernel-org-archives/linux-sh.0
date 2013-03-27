From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 15:13:34 +0000
Subject: Re: [PATCH 06/13] sh-pfc: r8a73a4: Add IRQC pin groups and functions
Message-Id: <CANqRtoTf88yrYq0RpqNsFw3CvB=1-ABtKKzfiSfPXHjk_4UHSw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326135046.31366.2271.sendpatchset@w520>
In-Reply-To: <20130326135046.31366.2271.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Mar 27, 2013 at 1:02 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thanks for the patch.
>
> On Tuesday 26 March 2013 22:50:46 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add PINCTRL support for r8a73a4 IRQC hardware
>> and in particular the external pins IRQ0 -> IRQ57.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  187 +++++++++++++++++++++++++++++++
>>  1 file changed, 187 insertions(+)
>>
>> --- 0010/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
>> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c 2013-03-26
> 19:36:03.000000000
>> +0900 @@ -1619,6 +1619,73 @@ static const unsigned int scifb3_ctrl_b_
>>  static const unsigned int scifb3_ctrl_b_mux[] = {
>>       SCIFB3_RTS_38_MARK, SCIFB3_CTS_39_MARK,
>>  };
>> +/* - IRQC
>> ------------------------------------------------------------------- */
>
> Could you please keep the groups and functions alphabetically sorted ? The
> pfc-*.c files are pretty tedious to read (and write), and a random order of
> groups and functions would make my headache medecine bill become more
> expensive :-)

Done! Good news is that updating those couple of hunks in the middle
of the file didn't seem to cause rejects for patches later in the
series.

> The patch otherwise looks good.

Thanks. I've now posted a V2 as "[PATCH v2] sh-pfc: r8a73a4: Add IRQC
pin groups and functions".

Cheers,

/ magnus
