From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2014 07:40:14 +0000
Subject: Re: [PATCH 0/5] R-Car Gen2 removal and cleanups
Message-Id: <CANqRtoRW0grFb4d9Lz6vMmcfU3U2EU8c9tSH-jLhEPqLqwoH_w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Dec 4, 2014 at 4:32 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Simon,
>
> On Thursday 04 December 2014 15:47:31 Simon Horman wrote:
>> On Tue, Dec 02, 2014 at 11:44:29PM +0200, Laurent Pinchart wrote:
>> > On Tuesday 02 December 2014 22:06:49 Geert Uytterhoeven wrote:
>> >> On Tue, Dec 2, 2014 at 5:35 PM, Laurent Pinchart wrote:
>> >>> This patch series remove the Lager legacy and reference board files
>> >>> from the kernel. It builds upon two patches previously posted by
>> >>> Magnus and updated to removal left-overs.
>> >>>
>> >>> The rationale for the change, beside keeping the ARM SoC maintainers
>> >>> happy, is that the Lager board is now correctly supported using DT
>> >>> boot and generic code only, so there's no reason to keep board files
>> >>> along.
>> >>
>> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >>
>> >>> The second reason to repost the patches is to include a pet peeve of
>> >>> mine that I've been carrying in my local branches for too long. The
>> >>> last two patches update the Lager and Koelsch DT files to finally
>> >>> rename the two serial ports to ttySC0 and ttySC1.
>> >>
>> >> I'm not opposed to this change.
>>
>> IIRC, this has been a contentious issue in the past.
>> I will confer with Magnus to make sure we are all happy with this change.
>
> If I recall correctly the major issue back then was synchronization of serial
> port names between legacy and DT boot. Now that Lager and Koelsch legacy have
> been removed, there should at least be no synchronization issue anymore. I'll
> wait for feedback from Magnus of course.

You're right. I have no issues merging this now.

Cheers,

/ magnus
