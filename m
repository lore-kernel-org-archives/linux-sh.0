From: Rob Landley <rob@landley.net>
Date: Sat, 12 Jan 2019 04:21:30 +0000
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header files
Message-Id: <d329d7b8-62fb-9cb0-521e-ee7887f122a1@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
 <20190110235428.GA10016@roeck-us.net>
In-Reply-To: <20190110235428.GA10016@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, y2038@lists.linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, arnd@arndb.de, deepa.kernel@gmail.com, Philippe Ombredanne <pombredanne@nexb.com>, Simon Horman <horms+renesas@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>

On 1/10/19 5:54 PM, Guenter Roeck wrote:
> On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
>> Unified system call table generation script must be run to
>> generate unistd_32.h and syscall_table.h files. This patch
>> will have changes which will invokes the script.
>>
>> This patch will generate unistd_32.h and syscall_table.h
>> files by the syscall table generation script invoked by
>> sh/Makefile and the generated files against the removed
>> files must be identical.
>>
>> The generated uapi header file will be included in uapi/-
>> asm/unistd.h and generated system call table header file
>> will be included by kernel/syscall_32.S file.
>>
>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> 
> Have you tested this patch ?

I tested it at one point, but not recently. (It was before 4.20 came out...)

Rob
