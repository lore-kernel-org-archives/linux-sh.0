From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 08 Jan 2020 08:35:54 +0000
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Message-Id: <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
In-Reply-To: <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Richard Henderson <rth@twiddle.net>, Parisc List <linux-parisc@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, alpha <linux-alpha@vger.kernel.org>, linux-ntb@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>



Le 08/01/2020 à 09:18, Krzysztof Kozlowski a écrit :
> On Wed, 8 Jan 2020 at 09:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Krzysztof,
>>
>> On Wed, Jan 8, 2020 at 9:07 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Tue, Jan 7, 2020 at 5:53 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> The ioread8/16/32() and others have inconsistent interface among the
>>>> architectures: some taking address as const, some not.
>>>>
>>>> It seems there is nothing really stopping all of them to take
>>>> pointer to const.
>>>
>>> Shouldn't all of them take const volatile __iomem pointers?
>>> It seems the "volatile" is missing from all but the implementations in
>>> include/asm-generic/io.h.
>>
>> As my "volatile" comment applies to iowrite*(), too, probably that should be
>> done in a separate patch.
>>
>> Hence with patches 1-5 squashed, and for patches 11-13:
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I'll add to this one also changes to ioreadX_rep() and add another
> patch for volatile for reads and writes. I guess your review will be
> appreciated once more because of ioreadX_rep()
> 

volatile should really only be used where deemed necessary:

https://www.kernel.org/doc/html/latest/process/volatile-considered-harmful.html

It is said: " ...  accessor functions might use volatile on 
architectures where direct I/O memory access does work. Essentially, 
each accessor call becomes a little critical section on its own and 
ensures that the access happens as expected by the programmer."

Christophe
