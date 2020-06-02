From: "Michael Karcher" <michael.karcher@fu-berlin.de>
Date: Tue, 02 Jun 2020 10:19:07 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <52568.92.196.166.68.1591093147.webmail@webmail.zedat.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
    <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
    <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
    <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
    <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
    <20200601030300.GT1079@brightrain.aerifal.cx>
    <CAMuHMdUmpLRyYTPO8LPtOyYtraQ77XZqYy9=8cUiWphmpvczmg@mail.gmail.com>
    <fbfca28d-217d-4857-a010-8c6e277db67c@physik.fu-berlin.de>
    <20200601165700.GU1079@brightrain.aerifal.cx>
    <50235.92.201.26.143.1591043169.webmail@webmail.zedat.fu-berlin.de>
    <20200601205029.GW1079@brightrain.aerifal.cx>
In-Reply-To: <20200601205029.GW1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Michael Karcher <michael.karcher@fu-berlin.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Rich Felker schrieb:
>> There is a functional argument agains using get_user_32 twice, which I
>> overlooked in my private reply to Adrian. If any of the loads fail, we
>> do not only want err to be set to -EFAULT (which will happen), but we
>> also want a 64-bit zero as result. If one 32-bit read faults, but the
>> other one works, we would get -EFAULT together with 32 valid data bits,
>> and 32 zero bits.
> Indeed, if you do it that way you want to check the return value and
> set the value to 0 if either faults.

Indeed. And if you do *that*, the performance of the hot path is affected
by the extra check. The performance discussion below only applied to the
cold path, so it seems perfectly valid to disregard it in favore of better
maintainability. On the other hand, checking the return value has a
possibly more serious performance and size (and if you like at the
I-Cache, size means performance) impact. When discussing size impact,
we should keep in mind that put_user for fixed size is supposed to be
inlined, so it's not a one-time cost, but a cost per call. On the other
hand, though, put_user for 64-bit values on SH4 seems to be nearly never
called, so the impact is still most likely negligible.

> BTW I'm not sure what's supposed to happen on write if half faults
> after the other half already succeeded... Either a C approach or an
> asm approach has to consider that.
That's an interesting question. From a kernel developer's point of view,
it seems like a valid view to say: "If userspace provides a bad pointer
where the kernel has to put the data, it's a problem of userspace. The
kernel only needs to tell userspace that the write is incomplete." This
is different to the defensive approach used when reading from user space
into kernel space. Here forcing the whole 64 bit to be zero makes the
kernel itself more robust by removing strange corner cases.

> Indeed. I don't think it's a significant difference but if kernel
> folks do that's fine. In cases like this my personal preference is to
> err on the side of less arch-specific asm.
This is a good idea to reduce maintainance cost. I agree it's up to the
kernel folks to decide whether:
 - Half-zeroed reads of partially faulted 64-bit-reads are acceptable
 - Cold error checks in the hot path to ensure full zeroing is acceptable
 - maintainance of arch-specific asm on many 32-bit architectures is
acceptable.

I don't want to endorse one of these three options, as I am out of the loop
regarding kernel development priorities and philosophy, I just intend to
point out the different options the kernel has to pick the one that fits
best.

Regards,
  Michael Karcher
