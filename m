From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 21:40:41 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Get rid of redundant EMEV2 mach callbacks
Message-Id: <CANqRtoTschJA4888V2CPYdjeiThqn2R5w9sPREo=yxJ4AxNCdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140213082628.30630.3186.sendpatchset@w520>
In-Reply-To: <20140213082628.30630.3186.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Jun 5, 2014 at 5:13 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Thu, Jun 5, 2014 at 7:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> --- 0003/arch/arm/mach-shmobile/setup-emev2.c
>> +++ work/arch/arm/mach-shmobile/setup-emev2.c   2014-05-29 17:15:54.000000000 +0900
>> @@ -16,10 +16,9 @@
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>   */
>> -#include <linux/clk-provider.h>
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>> -#include <linux/of_platform.h>
>> +#include <linux/mm.h>
>
> Why is <linux/mm.h> needed?
>
> Ah, arch/arm/mach-shmobile/include/mach/common.h lacks a forward
> declaration of "struct task_struct;".
>
> And then you still need to add "#include <asm/page.h>" for PAGE_SHIFT,
> as <asm/memory.h> uses that in __phys_to_pfn().

The current state of the header files is a bit messy, yes. So this
should indeed be fixed.

I'd like to fix up the headers in general, but for this kind of stuff
I'm currently blocked on the following:

[PATCH 00/08] ARM: shmobile: Rework include path (Try 2, Part 1)
[PATCH 01/08] ARM: shmobile: Move intc.h, cleanup sh_intc.h usage
[PATCH 02/08] ARM: shmobile: Move dma-register.h
[PATCH 03/08] ARM: shmobile: Move clock.h
[PATCH 04/08] ARM: shmobile: Move most of irqs.h, keep some for pinctl
[PATCH 05/08] ARM: shmobile: Move common.h
[PATCH 06/08] ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
[PATCH 07/08] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
[PATCH 08/08] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case

Do you have any opinion on this series? =)

Thanks,

/ magnus
