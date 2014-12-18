From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Dec 2014 10:11:35 +0000
Subject: Re: [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
Message-Id: <CANqRtoS6iFLB1Qi2JVS_dKgZOR_Y6Pzx8GjuJ6_MgR22vi62OQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094214.7039.68681.sendpatchset@w520>
In-Reply-To: <20141217094214.7039.68681.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Dec 18, 2014 at 6:30 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Thu, Dec 18, 2014 at 10:05 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> I really don't like losing 25% of RAM...
>>
>> Sure, so the ARM arch needs to be beaten into shape somehow. =)
>>
>> But compared to before we can at least boot multiplatform.
>
> An alternative solution is to change the memory region to include the first
> 16 MiB of RAM.

If that is possible then sure! I however always assumed that part of
the memory is reserved due to the SH core (or some other piece of
hardware) is using for other purposes.

Cheers,

/ magnus
