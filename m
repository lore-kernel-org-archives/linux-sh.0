Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5D1FAC4E
	for <linux-sh@vger.kernel.org>; Thu,  9 Jan 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455284; cv=pass; b=dLGywjdIh4D6bQZLNoLEQGrEadZvDxnOb5tdKQsihncj3b+NTg+Nym/aIrKcZdWbBBEb9ZNLZ6DEEu2tQ9Vlu7B1mOVrG3n2Wsu7rWf/b04xVYU79g33o7Shk254khZq0MLzE5GII71xL3ocv/nGF5YVZ5KGF4Kz1qoUmlDPB2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455284; c=relaxed/simple;
	bh=9FG7BpZjvc7vhk1Mtn5/XRvyXnmr2FjrnnMLhMfMI9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6Tr+TdhX/n9y6G95eHyB7wRVxUdU1oebi8V9F5IrqURVJmsTjSPHYergshNMqvbEWsuIiIsIb1XAjvR6RBo4EpmXj2bcFVR9+d1ZofvhLxlnVSa6r8IemE65hP6cbfV0hh8nMGH7eXtdjCYMvDkhsUj5QZHPdW0u23kxV4ecbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=VlPe1nyQ; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="VlPe1nyQ"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A284183C7A;
	Thu,  9 Jan 2025 20:41:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.112.36.102])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9F94B182251;
	Thu,  9 Jan 2025 20:41:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736455274; a=rsa-sha256;
	cv=none;
	b=jDEoJ62+YsENNcjFEuCGC358MEF+8Sc0RtIUJ46ER4MWSVhNEQEX5pssOdHnviDVbvY2tv
	7iowZ+GXoWgQ6sKKpwrHsuWcSbjV/RsdszHvEqBQckJw/BaCDvod2Lcs1bng92X9OFq+LC
	gjbQIxZt+xeEgGZTi1ayZ5XR2hSbRdaJqhn0N4gzlWmsoYVQtdjitSJzA1MNzrDDVVUPRa
	OguZDPMVSu931qWwkz4kJ/tzxs+6kIN3h9OtON1xu5PVHcLOCCFVfId4NRr5dGXWw0KpLv
	x4GBXGqNqkUipWGW1G8OSNKtYRs1/KeiNwjxHH+YUpTXK9W/kvXUsG7pHTRfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736455274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CEfvgEayPLlbzE7gU1T9L1nyEWHyyjI0IO8CyBojrIo=;
	b=icu1u641DL4TCmzcPu/JJoAffyGl+3QI2OUCpErX351wzlI/E/3222gwO6Y46TAlFIKrIM
	bHKVwhtsBt4GPJzEReRQzkRg6oQ/JUMph2GGyrrt1tJd0b2J5UUyzTzVz2T+0UJ+L6USak
	WzF4aLavIa9vVJGnXzoM5jHGCRDX1ppTj0S4/0YzNwL+7DpXfNBo7/GY6wFnDLsqanB9hz
	MKmxYBPMyhxGvLvVLkAyJyDg+N1+rEutUIkFt0/PuLYNowkhl6PWdhJqZPjndQ9Nkl3gQi
	AfaajLHwC66JwxOJEKpxQpXXNrWBqPCfWxR+Lpl0H/FDlKpoR93UrgUFJEql2A==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-t9kth;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Whistle: 22d6a4b535435412_1736455274920_4224451832
X-MC-Loop-Signature: 1736455274920:2709591090
X-MC-Ingress-Time: 1736455274919
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.36.102 (trex/7.0.2);
	Thu, 09 Jan 2025 20:41:14 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4YTcBf03WkzRK;
	Thu,  9 Jan 2025 12:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1736455274;
	bh=CEfvgEayPLlbzE7gU1T9L1nyEWHyyjI0IO8CyBojrIo=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=VlPe1nyQvmyulVVboxs3qC3I3srquCPpjFi+X9pNCO4Pqq7GNq6j7rhT1CrRYoRus
	 M7Nsp+p6NoasRnEG/L/hSGuvD4e4hV4tkdN33/9ycwtMRDJIGsoMtUsl6BUDb9pqhK
	 UBcKEK65np0e1cwutj3eWOY4/r2hElLVluxugoffPajdPrLJET/zRZblj0B/8D1y4l
	 li5OTXhRYTgkhYIrymuz5p1A44B2AzUH0WM/uUlbmVz5/Adcv7QEr0XZca9893cAPk
	 aKyuhc0rpw98C4/tK3Tf3L/6GLlWA7BRL/5z8Tg4K++SbrJe4pjFCFRZmXE9y/uNbk
	 gDQWkjqzENxDA==
Message-ID: <27b9943c-723f-47ad-a86e-954ac371c867@landley.net>
Date: Thu, 9 Jan 2025 14:41:12 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
 <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
 <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
 <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
 <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
 <CAMuHMdVZU1JBFg_Z8gkvi=ovXdyFomvG4R-oUUCKiiuyXs2LKQ@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdVZU1JBFg_Z8gkvi=ovXdyFomvG4R-oUUCKiiuyXs2LKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/25 02:49, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> CC linux-sh
> 
> On Wed, Jan 8, 2025 at 11:40 PM Rob Landley <rob@landley.net> wrote:
>> The sh2eb turtle board uses JCORE_EMAC which is still an out of tree
>> driver. It's not secret, just too ugly to go upstream: done by a
>> contractor and never cleaned up, full of half-finished IEEE-1588 support
>> and so on. It used to be on
>> https://web.archive.org/web/20200812035510/http://git.musl-libc.org/cgit/linux-sh/
>> but alas Rich purged his trees when he stopped being maintainer and
>> archive.org didn't crawl that far down.
>>
>> I have the patch locally if you care, but without the corresponding
>> hardware, not much point attaching 1600 lines. (We sent several turtle
>> boards to Glaubitz and his assistants last year, and at least one of the
>> recipients asked for a copy of the ethernet driver patch, which I sent.
> 
> I still have to ask you for that driver, so yes I am interested in
> the patch ;-)

I sent it directly because we're spamming the lists enough already 
without large attachments. :)

>> Still applies and works as of the last kernel I updated on the board,
>> 6.18 I think? The update is a "pop the sd card, stick in laptop, copy
>> files, move sd card back" kinda thing.
> 
> ... which has been the main obstacle for me to integrate turtleboard
> in my regular kernel testing workflow. There are only 24 hours in a day,
> so usually there is no time left for juggling SD cards :-(

Yeah, I should do something about that. Using linux+kexec as a stage 2 
bootloader, linux could wget from/init initramfs and you could just 
stick the file on a web server. (I could also use tftp, but toybox or 
busybox httpd is trivial to set up on a high port...)

>> I should do a linux image that
>> can wget and kexec, but haven't yet... Anyway, doesn't help with this
>> issue.)
> 
> Does kexec work on MMU-less J2?

I thought I'd hacked something up once, but then there was a pandemic 
and an insurrection and I honestly don't recall the details...

The main limiting factor on software reboot in the FPGA version is the 
bitstream preloads values into SRAM blocks, which aren't preserved after 
boot. That's really all a bitstream _does_, initialize sram in the chip 
to known starting values, it's just some of those sram blocks are in 
"lookup tables" (LUTs) that act as logic gates, except all a LUT is 
REALLY doing internally is "this set of input bits = this output bit", 
hence the name lookup table, it's address = value lookup for single 
bits. But that's all and/or/nor gates do anyway, so... (There's also 
'switching fabric" which is "which wires connect to which 
inputs/outputs"... again SRAM controls it by setting bits to flip 
switches on and off to connect together the wires...)

Anyway, FPGAs also have big sram blocks in them (in the ice40 8k we're 
using, they come in 512 byte and 64k byte sizes, something like 2 dozen 
of the small ones and 2 of the big ones, xilinx has more and probably 
bigger), and the bitstream can have initialization values for those too.

In turtle, some of those preloaded address blocks get used as a boot 
ROM, which _could_ be marked read only and preserved (it's like a 1 line 
change in the VHDL, in that big address resolution if/else staircase) 
but there's a limited amount of sram in the board (especially 
conveniently placed near the ALU and so on), and what winds up happening 
is it's recycled as cache memory and such after boot, so when you go "I 
wanna reboot now" we ain't got that boot rom contents no more.

If you press the button it toggles the FPGA's hardware reset line which 
reloads the bitstream from the flash (in ice40 this is built in to the 
FPGA, in our xilinx designs the atmel chip does it), reinitializing the 
boot rom along the way. (Since we got the high speed quad data mode 
working it takes a fraction of a second.)

But rebooting from _software_ is only supported in ASIC, not FPGA. (Or 
possibly on the really big kintex chips that have resources out the 
wazoo, there may be a config toggle in the big j2 build? It's not in the 
ice40 j1 source, which is all I've looked at recently. That's the red 
square mounts, I don't think we've ever made a board less than 2 feet 
long that those plug into. We haven't sent them out to open source devs, 
they're hundreds of dollars each and need a heat sink and actual power 
supply, and only clock maybe twice as fast as the spartan 6 lx45 in a 
turtle. They have way way way more LUTs and such, of course...)

So to software reboot, we need a kexec method that doesn't go back 
through the boot rom, and I believe the kernel's built-in "kexec" 
mechanism worked at one point?

Because it's nommu (and the board currently hasn't got any hardware 
doing DMA, although we have some bitstream upgrades to add that in the 
works), you don't have to tear down the page tables and quiesce the A20 
line and similar nonsense, you basically just tell the IRQ controller to 
stop generating any interrupts, load the kernel into a high contiguous 
block (which can be pretty fscking hard if the system's been running a 
while due to fragmentation issues inherent in nommu systems that didn't 
reserve memory to start with), and jump to the decompression code that 
gunzips it down into the lower area of ram (smashing whatever's there). 
Then it jumps to the entry point and the kernel's init resets all the 
hardware as the drivers load. (I think the serial port is assumed to 
already be set to the right speed by the bootloader, the rest gets 
re-initialized by the drivers? Been a while...)

If all you want is "bootloader loads temporary kernel, then first thing 
temporary kernel does is kexec a file out of a mount point", 
fragmentation shouldn't be a problem because the top half of memory 
never got touched. (well, "echo 3 > /proc/sys/vm/drop_caches" for luck.) 
I think it just worked at one point? (Many moons ago. Might have had to 
hack the kernel config plumbing to get it ENABLED, but that's a modern 
kernel for you...)

> On SH4, there was never an upstream kernel that worked with upstream
> kexec-tools.

I didn't use kexec tools, there's a syscall. Have you tried the simple 
thing? Checking the man page, something like:

int main(int argc, char *argv[])
{
   int kern, initrd, cmdline;

   if (argc<4) exit(dprintf(2, "needs 3 arguments: kernel.img initrd.gz 
'command line'\n"));

   kexec_file_load(open(argv[1], O_RDONLY), open(ARGV[2], O_RDONLY), 
strlen(argv[3]), argv[3], KEXEC_FILE_UNLOAD);
}

You could theoretically even (and this is disgusting):

kexec <(wget -O- http://1.2.3.4:8888/kernel) <(wget -O- 
http://1.2.3.4:8888/initramfs) "$(wget -O- http://1.2.3.4:8888/cmdline)"

I don't think the turtle board comes with dhcp by default, but there's 
one in toybox's pending directory you could switch on for mkroot. (Or do 
you want a static busybox binary for turtle?)

> The only one that works is the kexec binary from the old
> landisk distro, which predates SH support in upstream kexec-tools,
> and can only start a new kernel from a system that is running kernel
> 2.6.22...

Never even looked at it. I think there's a kexec in klibc and another in 
busybox, but mostly there's a pair of syscalls one of which provides a 
simple API without needing to know what a kexec_segment is.

I note that I have ZERO memory of actually doing this, possibly I gave 
something like the above description to a co-worker and they did the 
actual debugging to make it work? (Or it was mid-pandemic, there are 
whole months that are just a blur...)

(The real problem is I send things to the other enginers, they use them 
for a while, it got archived when switching to a new project for a new 
customer, and then I have to go "I already solved this problem" and fish 
something out of my email outbox from 2021. They forgot about it because 
we migrated servers and archived the old wiki and THAT build system was 
on the mac trashcan not the new rackmount thing... Of course I can't 
complain when I'm the one currently failing to remember (mostly because 
I didn't blog about it, grepping my blog and email outbox for keywords 
is half my institutional knowledge, being in the same room in tokyo and 
talking to people in PERSON doesn't leave a record like that). We need a 
technical archivist, and I'm already wearing too many hats...)

> BTW, this is seriously off-topic for openrisc and qemu, so please
> reduce the CC list when continuing the linux-sh discussion..

Trimmed. (No idea how Stafford, Peter, and Jason feel about it either...)

> Thanks!
> 
> Gr{oetje,eeting}s,

Rob

P.S. There _is_ a DMA engine in the big kintex build, but it's this 
giant 64 channel implementation designed to pass data to/from a string 
of giant DSPs, and the DMA engine _alone_ is bigger than the j2 
processor, and the smallest it can configure down to with the current 
config plumbing is 16 channels. We have a much smaller/simpler generic 
DMA engine for j1 sketched out, but we wound up not needing it for the 
project we designed it for (you can do a LOT with hard realtime PIO and 
a small fifo buffer, and honestly if you control the spi clock you don't 
need ANY buffer because you control the clock), and that was on J1 for 
ice40 and would take some porting for j2 anyway because there's a 
different bus layer and arguing with leingen is a bit of a timesink...
