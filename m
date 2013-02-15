From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 15 Feb 2013 01:47:04 +0000
Subject: Re: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
Message-Id: <CANqRtoRc0APsu8Ess1-TKNv5Ka3P2WK5Es0mgO_xdXv7hz7xUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130214122347.20778.10789.sendpatchset@w520>
In-Reply-To: <20130214122347.20778.10789.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Feb 15, 2013 at 12:56 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Feb 14, 2013 at 01:26:42PM +0100, Laurent Pinchart wrote:
>> Hi Magnus,
>>
>> Thanks for the patch.
>>
>> On Thursday 14 February 2013 21:23:47 Magnus Damm wrote:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > Fix sizeof() usage in sh-pfc/core.c to allocate space
>> > for the full data structure instead of a pointer.
>>
>> Oops :-)
>>
>> This is v3.9 material. Simon, could you please take this and push it upstream
>> for v3.9 ?
>
> Sure, will do.

Thanks.

/ magnus
