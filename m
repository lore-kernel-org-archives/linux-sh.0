From: Rich Felker <dalias@libc.org>
Date: Tue, 17 Dec 2019 23:13:19 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <20191217231319.GJ1666@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdUHGXkmKrcZVNQo8nOcGo0h6xYgjZ+XmfGy6bJCPK9ZwQ@mail.gmail.com>
 <CAMuHMdUc4yyXsp4Y4Xx==3mUMrUn5DO8G-rLA_Mnv-790n6Ehg@mail.gmail.com>
 <871rt3gwri.wl-kuninori.morimoto.gx@renesas.com>
 <1850003495.209647.1576573784839@mail.yahoo.com>
 <1933127148.546436.1576620988364@mail.yahoo.com>
In-Reply-To: <1933127148.546436.1576620988364@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Karl Nasrallah <knnspeed@aol.com>
Cc: kuninori.morimoto.gx@renesas.com, geert@linux-m68k.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Tue, Dec 17, 2019 at 10:16:28PM +0000, Karl Nasrallah wrote:
> Hello!
> 
> I have a strncpy for you.
> 
> static inline char *strncpy(char *__dest, const char *__src, size_t __n)
> {
> 	char * retval = __dest;
> 	const char * __dest_end = __dest + __n - 1;
> 
> 	// size_t is always unsigned
> 	if(__n = 0)
> 	{
> 		return retval;
> 	}
> 
> 	__asm__ __volatile__ (
> 					"strncpy_start:\n\t"
> 							"mov.b @%[src]+,r0\n\t"
> 							"cmp/eq #0,r0\n\t" // cmp/eq #imm8,r0 is its own instruction
> 							"bt.s strncpy_pad\n\t" // Done with the string
> 							"cmp/eq %[dest],%[dest_end]\n\t" // This takes care of the size parameter in only one instruction ;)
> 							"bt.s strncpy_end\n\t"
> 							"mov.b r0,@%[dest]\n\t"
> 							"bra strncpy_start\n\t"
> 							"add #1,%[dest]\n\t" // mov.b R0,@Rn+ is SH2A only, but we can fill the delay slot with the offset
> 					"strncpy_pad:\n\t"
> 							"bt.s strncpy_end\n\t"
> 							"mov.b r0,@%[dest]\n\t"
> 							"add #1,%[dest]\n\t"
> 							"bra strncpy_pad\n\t"
> 							"cmp/eq %[dest],%[dest_end]\n\t"
> 					"strncpy_end:\n\t" // All done
> 		: [src] "+r" (__src), [dest] "+r" (__dest)
> 		: [dest_end] "r" (__dest_end)
> 		: "t"
> 	);
> 
> 	return retval;
> }
> 
> Tested with sh4-elf-gcc 9.2.0 on a real SH7750/SH7750R-compatible
> system. No warnings, behaves exactly as per linux (dot) die (dot)
> net/man/3/strncpy and I optimized it with some tricks I devised from
> writing extremely optimized x86. If there are any doubts as to the
> authenticity, note that I am the sole author of this project: github
> (dot) com/KNNSpeed/AVX-Memmove

You're using r0 explicitly in the asm but I don't see where you're
reserving it for your use. You need it either on the clobbers or bound
to a dummy output with earlyclobber.

Rich
