From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Jan 2011 01:15:22 +0000
Subject: Re: [PATCH 08/08] sh: Move new memblock reservation code to drivers/sh
Message-Id: <AANLkTimyBJVQevTuxixaxj4Ahq6n=cvN7uMYPULV7kSL@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110106101659.1617.32582.sendpatchset@t400s>
In-Reply-To: <20110106101659.1617.32582.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Jan 7, 2011 at 1:02 AM, Masao Uebayashi <uebayasi@tombi.co.jp> wrot=
e:
> On Thu, Jan 06, 2011 at 07:16:59PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Move the new physically contiguous memory reservation
>> code from arch/sh into drivers/sh/memchunk.c to it can
>> be shared with SH-Mobile / R-Mobile ARM processors.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0arch/sh/mm/consistent.c | =A0 58 ----------------------------------
>> =A0drivers/sh/Makefile =A0 =A0 | =A0 =A01
>> =A0drivers/sh/memchunk.c =A0 | =A0 78 ++++++++++++++++++++++++++++++++++=
+++++++++++++
>> =A03 files changed, 79 insertions(+), 58 deletions(-)

Hi Uebayashi-san,

> Why do you have two copies of shmobile_memchunk_setup() in
> arch/sh/mm/consistent.c and here?
>
> Masao (new to this list)

The patch should move the function into drivers/sh, but perhaps I made
some mistake. So there shouldn't be two copies of the same function,
not sure how you get that.

Thanks,

/ magnus
