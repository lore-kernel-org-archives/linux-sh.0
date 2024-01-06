Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7717D5
	for <linux-sh@vger.kernel.org>; Sat,  6 Jan 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="gh7ATWRR"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba903342c2so14275339f.3
        for <linux-sh@vger.kernel.org>; Fri, 05 Jan 2024 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704513121; x=1705117921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enno4RDG7Jc2tI8Uw9IJMPfOQP8dq6cok+ed1FX+/z8=;
        b=gh7ATWRRRO4zPYNDnoVMr3CRnUPCarZxzyIwPDcu6zbDX5vLPvSxgIc9oKLWunSzS7
         0udeuafrZu2rS8qq40IfQZN1ilDRFRgnUDM4lr3SflPG10c5tNCfQAYY/nti64n/FGG8
         j9WIFQ4qy/tx8BrLonMjAVBJ1fvnWLffo/DYhCsYDikPt7qePXLFj4SYn5Slx3eFFdhB
         CgFXyQ5VEYdGG9i/fCWtvJTiSOmSNNF9w8maQLGCGPW4fyfBifas7+HcXW1l4f0TQQsq
         2zynch/KZyVcxm10xo1SxtlGuKqDPZtxGODQ+N0SRt0O/GeEbM8KMr17eZpz2dW0s2Gi
         hJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704513121; x=1705117921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enno4RDG7Jc2tI8Uw9IJMPfOQP8dq6cok+ed1FX+/z8=;
        b=e6rDY6AUGrFPEvROhErZo7puKoDXttaC5VcJGgszVPD4MfKAo8QsYQuZ+dwpmWFvJl
         a9nmZryU08YWOK1YjxURctmUfvnSDi69vpxqnL13Ouuo7BnmdIY+0Nn3Mmk8+c1oUOMQ
         qnvNUzUdNhqoDGnn/oBOnYb1z+RqXGHybsEc/tfHf+78HckzONm2kdg9/ZknTYFHfFcW
         WagfSevY4ldGDirocirsgXqbAuB81fZRFzIODvgQ+zcu/7iZzAZytvKBDiVDeEeRHJgq
         bV5Vb21/m81OEpkik4gv8t5FtU+9ZrpKPqiHhfIZHT2A00TAy96esdpTBZKlFWE6M2p+
         Ql9Q==
X-Gm-Message-State: AOJu0YzcU+UYvLY08ZoNf8yUCQNJeeqMFbyt8Oum1InN1dZ3BiISMT9C
	b35wbcBBNJQ7VEng/fYz02THyF2TEoQStQ==
X-Google-Smtp-Source: AGHT+IGTddaSjZgOGB35qmivrEEVWMRiyLxFuiI9YqBmA2e7RS9koXVG6vidS0Xx6CzgCLA+n146Kw==
X-Received: by 2002:a5d:8059:0:b0:7b4:28f8:519 with SMTP id b25-20020a5d8059000000b007b428f80519mr667420ior.25.1704513121061;
        Fri, 05 Jan 2024 19:52:01 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id ck15-20020a0566383f0f00b004665f85c6d7sm823366jab.4.2024.01.05.19.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 19:52:00 -0800 (PST)
Message-ID: <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
Date: Fri, 5 Jan 2024 21:58:30 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Call for nommu LTP maintainer [was: Re: [PATCH 00/36] Remove
 UCLINUX from LTP]
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven
 <geert@linux-m68k.org>, ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 automated-testing@lists.yoctoproject.org, buildroot@buildroot.org
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240105131135.GA1484621@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 07:11, Petr Vorel wrote:
>> Nobody is maintaining "uclinux" because that was a distro, but you can build
>> nommu support in buildroot and such, and people do.
> 
> Right, there are nommu users. Will anybody join LTP development to maintain
> nommu support in LTP? The needed work is to add this support to LTP new C API
> [1] and use it in the relevant test. There is some implementation in the old
> API, I have no idea how well it worked.
> 
> If nobody stands for maintaing nommu, we will have to delete it. There is nobody
> from the current maintainers who is using LTP on nommu HW (that is the reason why
> nommu support have not been implemented in the new API).

I'm interested, but overwhelmed. Not sure I've got the spoons to come up to
speed on a new project and give it regular attention just now.

I see you cc'd buildroot (although the message might not go through if you
aren't subscribed, dunno how clogged their moderation queue is these days, and
the cc: list is long enough it might twig anyway). They had a nommu fix go in
earlier this week (commit 98684ba7885b).

That said, qemu supports several nommu platforms and buildroot has defconfigs to
build systems for them:

$ git clone git://buildroot.org/buildroot
$ make help
$ make list-defconfigs | grep qemu
$ make qemu_ppc_bamboo_defconfig
$ make
  (time passes...)
>>> host-gettext-tiny 0.3.2 Extracting
gzip -d -c
/home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-tiny-0.3.2.tar.gz |
tar --strip-components=1 -C
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2   -xf -
mkdir -p
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/gettext-gnu
xzcat /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-0.22.4.tar.xz |
tar --strip-components=1 -C
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/gettext-gnu
 -xf -
xzcat: /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-0.22.4.tar.xz:
No such file or directory
tar: This does not look like a tar archive
tar: Exiting with failure status due to previous errors
make: *** [package/pkg-generic.mk:209:
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/.stamp_extracted]
Error 2


Sigh, never build git pull du jour of anything, buildroot's having glitch du
jour. But the point is:

$ grep -rl bamboo board/
board/qemu/ppc-bamboo/readme.txt
$ cat board/qemu/ppc-bamboo/readme.txt
Run the emulation with:

qemu-system-ppc -nographic -M bamboo -kernel output/images/vmlinux -net
nic,model=virtio-net-pci -net user # qemu_ppc_bamboo_defconfig

The login prompt will appear in the terminal that started Qemu
-------------------

In THEORY, once it builds an image (presumably using a tagged release version
rather than expecting "continuous integration" to ever mean anything) you should
be able to launch it with qemu. Assuming the instructions aren't also
bit-rotted. (Or using one of the other nommu boards, I haven't gone through the
whole list to see what they've got. I used to use a nommu arm board, but the
linux kernel broke it when converting everything to device tree and not
regression testing it.)

Buildroot also apparently has an LTP package selectable in menuconfig:

https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite

But I haven't tried it...

Rob

P.S. I automate qemu testing all the time over in toybox, see testroot.sh under
https://github.com/landley/toybox/tree/master/mkroot for an example.
