From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Sep 2014 06:32:59 +0000
Subject: Re: [PATCH v3 0/4] Initial r8a7794/Alt support
Message-Id: <CANqRtoRWBgDNhAqmVdgjnWhSamfP7+7irVipgo7BWLaKheZF+w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409839350-1245-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409839350-1245-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon, Ulrich,

On Fri, Sep 5, 2014 at 1:18 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Sep 05, 2014 at 12:34:17PM +0900, Magnus Damm wrote:
>> On Thu, Sep 4, 2014 at 11:02 PM, Ulrich Hecht
>> <ulrich.hecht+renesas@gmail.com> wrote:
>> > Hi!
>> >
>> > This is a rebased version of v2 requested by Magnus with the parts that are
>> > supposed to go through Simon's tree.  It also splits board and SoC DT into
>> > two patches.
>> >
>> > CU
>> > Uli
>> >
>> >
>> > Changes since v2:
>> > - dropped bindings stuff
>> > - split SoC and board DT into two patches
>>
>> Hi Ulrich,
>>
>> This series looks good to me.
>>
>> Acked-by: Magnus Damm <damm+renesas@opensource.se>
>>
>> Like Khiem-san pointed out, perhaps the DTS needs some rework? From my
>> side it would be fine to handle that as incremental changes over time.
>>
>> Simon, would it be possible for you to pick up these patches? Do you
>> think the DTS patch shall be reworked once more, or is incremental
>> fixing OK?
>
> I would prefer if Ulrich re-spun the patches.
>
> I have had push-back from Olof in the past about including
> changes and fixes to said changes in the same pull-request.

Of course, resubmitting is fine. If you however think it is OK to
merge some individual patches as-is - like for instance 1-2 - then
that would of course be greatly appreciated.

Can please you tell Ulrich which patches you want him to resend?

Cheers,

/ magnus
