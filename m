From: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 22 Dec 2018 16:20:08 +0000
Subject: [for-next][PATCH 1/5] string.h: Add str_has_prefix() helper function
Message-Id: <20181222162856.518489380@goodmis.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

A discussion came up in the trace triggers thread about converting a
bunch of:

 strncmp(str, "const", sizeof("const") - 1)

use cases into a helper macro. It started with:

	strncmp(str, const, sizeof(const) - 1)

But then Joe Perches mentioned that if a const is not used, the
sizeof() will be the size of a pointer, which can be bad. And that
gcc will optimize strlen("const") into "sizeof("const") - 1".

Thinking about this more, a quick grep in the kernel tree found several
(thousands!) of cases that use this construct. A quick grep also
revealed that there's probably several bugs in that use case. Some are
that people forgot the "- 1" (which I found) and others could be that
the constant for the sizeof is different than the constant (although, I
haven't found any of those, but I also didn't look hard).

I figured the best thing to do is to create a helper macro and place it
into include/linux/string.h. And go around and fix all the open coded
versions of it later.

Note, gcc appears to optimize this when we make it into an always_inline
static function, which removes a lot of issues that a macro produces.

Link: http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com
Link: http://lkml.kernel.org/r/20181219211615.2298e781@gandalf.local.home
Link: http://lkml.kernel.org/r/CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggestions-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggestions-by: Joe Perches <joe@perches.com>
Suggestions-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/string.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..7927b875f80c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -456,4 +456,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) = 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.19.2
