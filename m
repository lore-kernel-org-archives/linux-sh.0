From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Oct 2011 22:44:40 +0000
Subject: [PATCH 1/2] sh: Correct logic errors in is_32bit()
Message-Id: <1318459481-23527-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This corrects logic errors so that is_32bit() can actually detect that it
is running on a 32 bit system - something the original version I wrote
failed at woefully.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/sh/kexec-sh.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 94ebbc7..a397d08 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -188,9 +188,8 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 static int is_32bit(void)
 {
 	const char *cpuinfo = "/proc/cpuinfo";
-	char line[MAX_LINE], key[MAX_LINE], value[MAX_LINE];
+	char line[MAX_LINE];
 	FILE *fp;
-	int count;
 	int status = 0;
 
 	fp = fopen(cpuinfo, "r");
@@ -198,14 +197,17 @@ static int is_32bit(void)
 		die("Cannot open %s\n", cpuinfo);
 
 	while(fgets(line, sizeof(line), fp) != 0) {
-		count = sscanf(line, "%s : %s", key, value);
-		if (count != 2)
+		const char *key = "address sizes";
+		const char *value = " 32 bits physical";
+		char *p;
+		if (strncmp(line, key, strlen(key)))
 			continue;
-		if (!strcmp(key, "address sizes")) {
-			if (!strcmp(value, "32 bits physical"))
-				status = 1;
-			break;
-		}
+		p = strchr(line + strlen(key), ':');
+		if (!p)
+			continue;
+		if (!strncmp(p + 1, value, strlen(value)))
+			status = 1;
+		break;
 	}
 
 	fclose(fp);
-- 
1.7.6.3

