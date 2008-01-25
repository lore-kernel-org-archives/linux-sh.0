From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 25 Jan 2008 04:16:21 +0000
Subject: Re: [PATCH] sh: use declared coherent memory for dreamcast pci ethernet adapter
Message-Id: <aec7e5c30801242016vf70588p53aaac8caeb8d683@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_29253_16868505.1201234581239"
List-Id: <linux-sh.vger.kernel.org>
References: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
To: linux-sh@vger.kernel.org

------=_Part_29253_16868505.1201234581239
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Jan 25, 2008 7:53 AM, Adrian McMenamin
<adrian@newgolddream.dyndns.info> wrote:
> On Thu, 2008-01-24 at 22:33 +0000, Adrian McMenamin wrote:
> > On Thu, 2008-01-24 at 18:40 +0900, Magnus Damm wrote:
> > > sh: use declared coherent memory for dreamcast pci ethernet adapter
> > >
> > > This patch makes the dreamcast use the recently added declared coherent
> > > memory functions to point out the memory window suitable for dma.
> > >
> > > Apart from cleaning up, this gives the dreamcast a proper memory allocator
> > > for pci dma memory.
> > >
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >
> >
> > I get this now:
> >
> > [    2.894858] IP-Config: Failed to open eth0
> > [    2.898395] IP-Config: No network devices available.
> >
> > So it appears, on first blush, that the patch breaks the driver. I'll
> > test further to confirm.
> >
>
> I can confirm that the patches:
>
> f838a96ef5cdc261cb458b154e79b259688008b8
> b82c3460d4a2d86cdac80e178a76f3833f1aecba
> 1b0a4750bf70d0e6f1b4ef573b1231530b9891be
>
> all need to be reverted as they break the Dreamcast network driver

Hi Adrian,

Thanks for testing and sorry about breaking the dreamcast ethernet
driver. We do need declared coherent memory support for the sm501 chip
and there shouldn't be any problems with using that interface for the
dreamcast. At least in theory. =)

I did unfortunately introduce a generic bug with the declared coherent
memory V2 patch yesterday, but I've posted a fix for that earlier
today. I don't however think that fix will help you. What you're
seeing seems to be that IP-config doesn't work which hints that packet
data isn't transferred as it should. And in your case it's most likely
because some virtual address or dma handle isn't setup properly.

The main thing here is that dma_alloc_coherent() should return the
same virtual address and dma handle regardless if my coherent patches
are applied. Or the values should at least be sane.

Can you please apply the attached patch and test both with and without
the 3 declared coherent patches? I'd like to see the values printed
out by printk() both with and without the declared coherent patches.

Thank you.

/ magnus

------=_Part_29253_16868505.1201234581239
Content-Type: application/octet-stream;
 name=linux-2.6.25-pre-sh-8139too-dma-printk-20080125.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbu7ugfa0
Content-Disposition: attachment;
 filename=linux-2.6.25-pre-sh-8139too-dma-printk-20080125.patch

LS0tIDAwMDEvZHJpdmVycy9uZXQvODEzOXRvby5jCisrKyB3b3JrL2RyaXZlcnMvbmV0LzgxMzl0
b28uYwkyMDA4LTAxLTI1IDEzOjA4OjQ2LjAwMDAwMDAwMCArMDkwMApAQCAtMTMxMSw2ICsxMzEx
LDE1IEBAIHN0YXRpYyBpbnQgcnRsODEzOV9vcGVuIChzdHJ1Y3QgbmV0X2RldmkKIAkJCQkJICAg
JnRwLT50eF9idWZzX2RtYSwgR0ZQX0tFUk5FTCk7CiAJdHAtPnJ4X3JpbmcgPSBkbWFfYWxsb2Nf
Y29oZXJlbnQoJnRwLT5wY2lfZGV2LT5kZXYsIFJYX0JVRl9UT1RfTEVOLAogCQkJCQkgICAmdHAt
PnJ4X3JpbmdfZG1hLCBHRlBfS0VSTkVMKTsKKworCXByaW50aygienp6enp6eno6IgorCSAgICAg
ICAidHhfYnVmcyA9IDB4JTA4bHgvMHglMDhseCwgIgorCSAgICAgICAicnhfcmluZyA9IDB4JTA4
bHgvMHglMDhseCwgIgorCSAgICAgICAiKDB4JTA4bHgpXG4iLAorCSAgICAgICAodW5zaWduZWQg
bG9uZyl0cC0+dHhfYnVmcywgKHVuc2lnbmVkIGxvbmcpdHAtPnR4X2J1ZnNfZG1hLAorCSAgICAg
ICAodW5zaWduZWQgbG9uZyl0cC0+cnhfcmluZywgKHVuc2lnbmVkIGxvbmcpdHAtPnJ4X3Jpbmdf
ZG1hLAorCSAgICAgICAodW5zaWduZWQgbG9uZyl0cC0+cGNpX2Rldi0+ZGV2LmRtYV9tZW0pOwor
CiAJaWYgKHRwLT50eF9idWZzID09IE5VTEwgfHwgdHAtPnJ4X3JpbmcgPT0gTlVMTCkgewogCQlm
cmVlX2lycShkZXYtPmlycSwgZGV2KTsKIAo=
------=_Part_29253_16868505.1201234581239--
