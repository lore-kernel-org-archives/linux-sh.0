From: Rob Landley <rob@landley.net>
Date: Sun, 29 Mar 2020 02:10:38 +0000
Subject: Re: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
Message-Id: <db57466b-8635-6c71-55bd-51c228490f3c@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------479B1A57757F7B903A4373D9"
List-Id: <linux-sh.vger.kernel.org>
References: <20200315175108.9694-2-romain.naour@gmail.com>
In-Reply-To: <20200315175108.9694-2-romain.naour@gmail.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------479B1A57757F7B903A4373D9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Binutils 2.33.1 needs explicit alignment directives or sh kernel won't boot.

https://www.spinics.net/lists/linux-sh/msg56835.html
https://www.spinics.net/lists/linux-sh/msg56836.html

Patches attached, acked by arch maintainer and tested by me.

On 3/28/20 5:29 AM, Geert Uytterhoeven wrote:
> CC arnd
> 
> On Fri, Mar 27, 2020 at 11:00 PM Rob Landley <rob@landley.net> wrote:
>> On 3/26/20 3:42 PM, Rich Felker wrote:
>>> On Sun, Mar 15, 2020 at 06:51:08PM +0100, Romain Naour wrote:
>>>> Since the patch [1], building the kernel using a toolchain built with
>>>> Binutils 2.33.1 prevent booting a sh4 system under Qemu.
>>>> Apply the patch provided by Alan Modra [2] that fix alignment of rodata.
>>>>
>>>> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=ebd2263ba9a9124d93bbc0ece63d7e0fae89b40e
>>>> [2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html
>>>>
>>>> Signed-off-by: Romain Naour <romain.naour@gmail.com>
>>>> Cc: Alan Modra <amodra@gmail.com>
>>>
>>> Acked-by: Rich Felker <dalias@libc.org>
>>
>> Is there any way to get this into sunday's release?
> 
> Not if the maintainer isn't in CC.
> 
>> Acked-by: Rob Landley <rob@landley.net>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

[Puppy eyes intensify.]

Rob

--------------479B1A57757F7B903A4373D9
Content-Type: text/x-patch; charset=UTF-8;
 name="patch1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch1.patch"

From:   Romain Naour <romain.naour@gmail.com>
To:     linux-sh@vger.kernel.org
Cc:     Romain Naour <romain.naour@gmail.com>,
        Alan Modra <amodra@gmail.com>
Subject: [PATCH 1/2] arch/sh: vmlinux.scr
Date:   Sun, 15 Mar 2020 18:51:07 +0100
Message-Id: <20200315175108.9694-1-romain.naour@gmail.com>

Since the patch [1], building the kernel using a toolchain built with
Binutils 2.33.1 prevent booting a sh4 system under Qemu.
Apply the patch provided by Alan Modra [2] that fix alignment of rodata.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=ebd2263ba9a9124d93bbc0ece63d7e0fae89b40e
[2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html

Signed-off-by: Romain Naour <romain.naour@gmail.com>
Cc: Alan Modra <amodra@gmail.com>
Acked-by: Rich Felker <dalias@libc.org>
Tested-by: Rob Landley <rob@landley.net>
---
 arch/sh/boot/compressed/vmlinux.scr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/compressed/vmlinux.scr b/arch/sh/boot/compressed/vmlinux.scr
index 862d74808236..dd292b4b9082 100644
--- a/arch/sh/boot/compressed/vmlinux.scr
+++ b/arch/sh/boot/compressed/vmlinux.scr
@@ -1,6 +1,6 @@
 SECTIONS
 {
-  .rodata..compressed : {
+  .rodata..compressed : ALIGN(8) {
 	input_len = .;
 	LONG(input_data_end - input_data) input_data = .;
 	*(.data)
-- 
2.24.1


--------------479B1A57757F7B903A4373D9
Content-Type: text/x-patch; charset=UTF-8;
 name="patch2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch2.patch"

From:   Romain Naour <romain.naour@gmail.com>
To:     linux-sh@vger.kernel.org
Cc:     Romain Naour <romain.naour@gmail.com>,
        Alan Modra <amodra@gmail.com>
Subject: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
Date:   Sun, 15 Mar 2020 18:51:08 +0100
Message-Id: <20200315175108.9694-2-romain.naour@gmail.com>

Since the patch [1], building the kernel using a toolchain built with
Binutils 2.33.1 prevent booting a sh4 system under Qemu.
Apply the patch provided by Alan Modra [2] that fix alignment of rodata.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=ebd2263ba9a9124d93bbc0ece63d7e0fae89b40e
[2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html

Signed-off-by: Romain Naour <romain.naour@gmail.com>
Cc: Alan Modra <amodra@gmail.com>
Acked-by: Rich Felker <dalias@libc.org>
Tested-by: Rob Landley <rob@landley.net>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..d46d34b58c96 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -374,6 +374,7 @@
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
+	. = ALIGN(8);							\
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
-- 
2.24.1


--------------479B1A57757F7B903A4373D9--
