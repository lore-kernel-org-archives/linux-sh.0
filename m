From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 12:56:54 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <CANqRtoQ9Umt3QQjjLKJNppFnqB4fwAD4D6NmyJhkOfg_rSQ6yw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Tue, Jul 9, 2013 at 9:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 09-07-2013 12:32, Kuninori Morimoto wrote:
>
>> This patch adds a sample DT-based Bock-W "reference" implementation.
>> The use of platform-specific C-code should be avoided
>> with this configuration as much as possible.
>
>
>    I don't quite understand why you've made BOCK-W bootable only with DT in
> the first place if you're now also making the reference platform for it.

The reason for not using MACHINE_START is that we most likely are not
allowed to add new board support without DT_MACHINE_START.

I base this on what happened when we added kzm9g, kzm9d and
armadillo800eva to the upstream kernel. At that point we had unique
mach-type numbers registered and wanted to use MACHINE_START, but we
were requested to instead relying on the value from the boot loader
make use of appended DTB and DT_MACHINE_START.

Regarding the differences between regular board-xxx.c and
board-xxx-reference.c, please search the mailing lists.

Hope this clarifies.

Cheers,

/ magnus
