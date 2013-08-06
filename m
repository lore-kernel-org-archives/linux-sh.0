From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Aug 2013 02:02:58 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: Use DT for GIC
Message-Id: <CANqRtoQ8OjaUvgx7baHMyH-qk1sywzirs085zzGkVKWr40sxsw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87iozo8umw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iozo8umw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 6, 2013 at 9:14 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Aug 01, 2013 at 11:42:36PM -0700, Kuninori Morimoto wrote:
>>
>> Hi
>>
>> The Subject was wrong
>>
>> - [PATCH 0/2] ARM: shmobile: Use DT for GIC
>> + [PATCH 0/4] ARM: shmobile: Use DT for GIC
>>
>> And, I didn't indicate base branch.
>> These are based on renesas-devel-20130801v2 tag
>
> Thanks.
>
> Magnus, could you please review this series?

The series looks good to me. Removes unneeded C setup code and also
reduces number of lines by moving code out of the intc files.

Acked-by: Magnus Damm <damm@opensource.se>

Thanks,

/ magnus
