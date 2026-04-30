Received: from cichlid.ash.relay.mailchannels.net (cichlid.ash.relay.mailchannels.net [23.83.222.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085722D792
	for <linux-sh@vger.kernel.org>; Thu, 30 Apr 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579822; cv=pass; b=FOLZhAVqk1EyXV6azokbyFyFF0lle9/QLCRChR9362zSnb++/I1SKRU/6xS8fC36BTXHxVVLn09n/dHcBwbCdA9gBBrUwaOsAabUt26RkV6SY4AQknPafmQtzVuIRQz37YsJd8F498UWMtXH+nWMD4386TSZFMbIuyD0rZ68o0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579822; c=relaxed/simple;
	bh=84jhDB8yZmaIgRZ6z/nyh1whCqU0czahftIgDhkP7s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9cmS7lZnivQbIula6+g4GQh1zhme7qhXZNY6AGdtl7OqnwOxTd1ClYPtARGuAOCJvdB1h0xA5RWCVoAX2yNWoff1zTBMrLFHyKFvW2m4d7J9f+W2KYc2sOq+ccwbYcidBEfNXSDBIrQfXOAt/idiG5bceQeA28uDZW9vFzJrBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=uz35dEW9; arc=pass smtp.client-ip=23.83.222.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="uz35dEW9"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2D54B7226CF;
	Thu, 30 Apr 2026 20:10:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.97.143.133])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C6A637227A0;
	Thu, 30 Apr 2026 20:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777579813;
	b=vNFDg8eCPHwynxNKQVjEnzMPhfCkSvyezMXKsrdxmMwgHj04gAovECw4UMYAginiW6pETn
	8E6nmBPrQgJgrKOR5GDW8AUsdHyFc/lGa5/+d9vAPk5/PIwIaYz+i15103mfZs6KRUAkoC
	kKFzyT8+kPHz7IQjSlLpVwlJzd7OCiKSR8rCLLz3Asr86452BWGDTeT2BB5+ThXEyjct4/
	B4N7BlI6LUZPVmFnC6goyD3/agc0w4aXs6kFkFlfoeYcSNyk/vanCDCj12BbMD5Niyedn4
	4TTsN/cH8vELm2uhO+3WsdzzxikqH+qGqUhrQB8U3odOGh436uTJzLp48O04qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777579813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZwULyZiNJYwGs/5sd7R7Sf1ylp/sg7bwkJRu8N2n9bw=;
	b=kDEv9zJFZe/beENMtiD2UQewT3iSQCB5ZOqzmsEOAV2tzhuLk0yyTE7/4mo6UIKmKP6kf2
	6AGE1bxL5gakY3e07lteLu3ZenRA1eW+gbvwBTAPgLts6D6fgPpQ4hG6aGeEU8QsRhASQ0
	ygWCSunFdw8zeLGR0u/n33GZu/+xrKCcXmxegvdR0qNxzZNtqxTk6QI/TIt69Sa3fGxT9l
	P4RmfdfhKhy06yZtCyxjBseOhiTkEFwtis5RFbxgYO2GlbBc79Qr+9z6acrRir1ZeZU8jU
	LgZt3StCfpcQzEcAXkCBqM9pfVs2Cwcc3tR3SWpf0Tpg8vvgXohMVWFT3FvmDg==
ARC-Authentication-Results: i=1;
	rspamd-798d95666b-hdc5l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Army: 217005ae3d11ab03_1777579814020_3639325708
X-MC-Loop-Signature: 1777579814020:3050824139
X-MC-Ingress-Time: 1777579814019
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.143.133 (trex/7.1.5);
	Thu, 30 Apr 2026 20:10:14 +0000
Received: from [192.168.88.6] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4g64z93J59z107D;
	Thu, 30 Apr 2026 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1777579813;
	bh=ZwULyZiNJYwGs/5sd7R7Sf1ylp/sg7bwkJRu8N2n9bw=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=uz35dEW9Vh5BNpLTo4nMe5MlSZUFS5nykAaf2LQQFt1NrhUhNI80eTS0/55NAk/h2
	 L5E+g5zk2hYwCj5nmo+zGqTgEqqnXCDUh608qQLvqD3qDftg7frmzcrYsVoAnjE6BT
	 Ie5L6KtuvVuaxZ4PISZAVCWWzZTrK5z3FadSZd2qzfwJkxYXPoyt0qRC2m8S2/ZWwb
	 2/T+vdpwthjJ8loxtT5K3rRJHEM9XG8N9Tih3JrGsYvSGAJjL+7lgkkDadLjTAZs3P
	 8tboELMy2JUQOaxCBUYqq6fqbNcADX72Z9IEpcmQqeHCd2yFh7Oi9Xfwxkxn/rcHzF
	 ljy44og2EqiXQ==
Message-ID: <c1cbf376-9bd2-4c2b-aed4-e7c378ac7301@landley.net>
Date: Thu, 30 Apr 2026 15:10:12 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/29/26 02:46, John Paul Adrian Glaubitz wrote:
> Hi Rob,
> 
> I'm trying to build a new root image after updating Toybox but that no longer works:
> 
> glaubitz@node54:/data/home/glaubitz/toybox> make root CROSS=sh2eb-linux-muslfdpic- LINUX=/data/home/glaubitz/sh-linux
> mkroot/mkroot.sh  -- LINUX=/data/home/glaubitz/sh-linux CROSS=sh2eb-linux-muslfdpic-
> No ccc symlink to compiler directory.

You're using CROSS= with the CROSS_COMPILE= syntax. They mean different 
things.

CROSS= is the syntax that just specifies the target architecture and 
picks a cross compiler from a common directory (pointed to by ccc). The 
special names CROSS=all and CROSS=allnonstop build all the targets (the 
first stopping upon failure, the second continuing past failures. See 
root/build/log for log files afterwards, the extension .y is builds that 
succeeded, .n is builds that didn't succeed, and .txt is every command 
line run out of the $PATH when building.)

CROSS_COMPILE= specifies a compiler prefix to use out of the $PATH, or 
you can CROSS_COMPILE=/path/to/prefix- to supply path and prefix in one. 
In which case the plumbing will use the start of the prefix up to the 
first dash as the target architecture name for finding the kernel config 
and so on out of the big if/else staircase. (I should provide a way to 
independently override that, but it hasn't come up much.)

If you don't specify either it builds using the host compiler, which is 
usually linking against glibc and thus absolutely incompetent at 
producing static binaries.

The supported targets and corresponding config data derived from them 
(kernel config and KARCH, qemu command line invocation including 
specifying the right serial output type, which file is actually the 
runnable kernel produced by the build, etc) are under 
https://codeberg.org/landley/toybox/src/branch/master/mkroot/mkroot.sh#L183 
which sets default values first and then overrides them for targets that 
don't use the most common option in a big if/else staircase.

For example, everything mkroot knows about the m68k target is:

>   elif [ "$CROSS" == m68k ]; then
>     QEMU_M=q800 KARCH=m68k
>     KCONF="$(be2csv MMU M68040 M68KFPU_EMU MAC BLK_DEV_SD MACINTOSH_DRIVERS \
>       NET_VENDOR_NATSEMI MACSONIC SCSI{,_LOWLEVEL,_MAC_ESP} \
>       SERIAL_PMACZILOG{,_TTYS,_CONSOLE})"

Which says qemu-system-m68k needs "-m q800" but otherwise uses the 
default qemu-system-$ARCH invocation (line 333, or see run-qemu.sh in 
any existing image), and that kernel needs ARCH=m68k.

Then KCONFIG= specifies kernel .config symbols in a very terse format, 
which is expanded three times:

1) be2csv = brace expansion to comma separated values, so bash's 
SCSI{,_LOWLEVEL,_MAC_ESP} becomes SCSI SCSI_LOWLEVEL SCSI_MAC_ESP and 
then all the spaces are turned into commas

2) csv2cfg produces miniconfig output, the above three becoming:

CONFIG_SCSI=y
CONFIG_SCSI_LOWLEVEL=y
CONFIG_SCSI_MAC_ESP=y

(Note that if one of the CSV is of the form BLAH=something then the 
=something will be used instead of adding =y, and yes it understands 
that commas inside "double quotes" are part of that value, not symbol 
separators. That's why the regex in csv2cfg is so horrible. If you need 
blah="thing with spaces" you can KCONF+=,symbol without running it 
through be2csv, as at least one architecture used to do? Or did I switch 
that to KCONFIG="$(be2csv blah),MORE=\"thing with spaces\"" for 
that/those target(s)? I forget...)

3) it's fed into the kernel's miniconfig plumbing which I documented 
twenty one years ago (yes in 2005, https://lwn.net/Articles/161086/). 
The plumbing glues on the GENERIC_KCONF list of default symbols (so I 
don't have to tell EVERY target to support ELF or ext2) and then calls

make allnoconfig KCONFIG_ALLCONFIG=mini.config

Those are the three files memorialized in root/sh4/docs and similar, by 
the way. The microconfig (csv after brace expansion), the miniconfig, 
and the full (sadly very version-specific) .config.

> make: *** [Makefile:108: root] Error 1
> glaubitz@node54:/data/home/glaubitz/toybox>
> 
> It asks me to create a "ccc" symlink but I have no clue where that link is supposed
> to point to.

It's at the end of https://landley.net/toybox/faq.html#cross although 
that links to another section which is a bit verbose...

> The FAQ says the link is supposed to »pointing at a directory full of
> cross compilers« but I don't have that and that's not my personal setup.

The ones I built are at https://landley.net/bin/toolchains/latest

You can extract the -cross ones from there into a directory for ccc to 
point at. (The -native.sqf ones are squashfs filesystems you can add to 
qemu with -hda or network block devices or similar.)

> I have the
> cross compilers installed in my home directory and their bin directories added to
> the PATH variable which has always worked in the past without any problems.

Try CROSS_COMPILE instead of CROSS, they mean different things.

> Can you explain how that "ccc" symlink works?

It contains directories called $ARCH-*cross and expects to find a 
compiler called $ARCH-*cross/bin/$CROSS*-cc in each. (It doesn't HAVE to 
be a symlink, it can be a directory, but installing piles of stuff under 
your get repo is not ideal.)

If the ccc/ directory exists and try to CROSS=help or something (any 
target it can't find), it lists the available targets.

> Thanks,
> Adrian

Rob
