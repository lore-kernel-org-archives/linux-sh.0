From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Mar 2013 06:13:22 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: tidyup clocks
Message-Id: <CANqRtoSDr8Uv0=zOtdvQcZqcipRTA7djQw6=NLK2dDnDu59bZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877gkti8g9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gkti8g9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Simon,

On Thu, Mar 28, 2013 at 9:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Mar 27, 2013 at 12:54:33AM -0700, Kuninori Morimoto wrote:
>>
>> Hi Simon, Magnus
>>
>> These patches tidyup current mach-shmobile clocks.
>> And, last patch adds MD pin check support on R-Car H1.
>>
>> 1), 2) removed DIV4_ZT* clocks which are not used from Linux/Software.
>> 3)     adds new macro for fixed ratio clock
>> 6)     tidyup r8a7740 clock mismatch implementation
>> 4), 5), 7) switch over to use 3)'s fixed ratio macro
>> 8)     add MD pin check support on R-Car H1, and used 3)'s fixed ratio macro
>>
>> These patches are tesed on mackerel/kzm9g/armadillo800eva/marzen board.
>> And these are based on simon's sh-arm/next branch
>> (442d651d3764ba4203c6b766a1ddd3ac24a40410)
>>
>> These are preparation on R-Car series clock support
>> (R-Car H1 was included as 8)
>
> These changes seem reasonable to me.
> Magnus, can I get an Ack?

Direction-wise these seem perfect to me. I have not compile tested
though, but I assume Morimoto-san will have time to deal with the
fallout if needed.

Acked-by: Magnus Damm <damm@opensource.se>

Thanks,

/ magnus
