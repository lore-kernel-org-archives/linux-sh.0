From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 12 Dec 2014 16:34:53 +0000
Subject: [PATCH v3 2/7] pinctrl: pinconf-generic: Allow driver to specify DT params
Message-Id: <c9b7ae3749494b2c94cafd556a476d67@BY2FFO11FD014.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1418402098-3811-1-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1418402098-3811-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Additionally to the generic DT parameters, allow drivers to provide
driver-specific DT parameters to be used with the generic parser
infrastructure.

To achieve this 'struct pinctrl_desc' is extended to pass custom pinconf
option to the core. In order to pass this kind of information, the
related data structures - 'struct pinconf_generic_dt_params',
'pin_config_item' - are moved from pinconf internals to the
pinconf-generic header.

Additionally pinconfg-generic is refactored to not only iterate over the
generic pinconf parameters but also take the parameters into account
that are provided through the driver's 'struct pinctrl_desc'.
In particular 'pinconf_generic_parse_dt_config()' and
'pinconf_generic_dump' helpers are split into two parts each. In order
to have a more generic helper that can be used to process the generic
parameters as well as the driver-specific ones.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
v2:
 - fix typo
 - add missing documentation for @conf_items member in struct
 - rebase to pinctrl/devel: conflict in abx500
 - rename _pinconf_generic_dump() to pinconf_generic_dump_one()
 - removed '_' from _parse_dt_cfg()
 - removed BUG_ONs, error condition is handled in if statements
 - removed pinconf_generic_dump_group() & pinconf_generic_dump_pin
   helpers
   - fixed up corresponding call sites
   - renamed pinconf_generic_dump() to pinconf_generic_dump_pins()
   - added kernel-doc to pinconf_generic_dump_pins()
 - add kernel-doc
 - more verbose commit message
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c |   2 +-
 drivers/pinctrl/pinconf-generic.c        | 182 +++++++++++++++++----------=
----
 drivers/pinctrl/pinconf.c                |   4 +-
 drivers/pinctrl/pinconf.h                |  22 ++--
 drivers/pinctrl/pinctrl-rockchip.c       |   2 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c     |   2 +-
 drivers/pinctrl/pinctrl-tz1090.c         |   2 +-
 drivers/pinctrl/sh-pfc/pinctrl.c         |   2 +-
 include/linux/pinctrl/pinconf-generic.h  |  18 +++
 include/linux/pinctrl/pinctrl.h          |   9 ++
 10 files changed, 141 insertions(+), 104 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nom=
adik/pinctrl-abx500.c
index e1087c75e4f4..de68c1f8477b 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -914,7 +914,7 @@ static int abx500_dt_subnode_to_map(struct pinctrl_dev =
*pctldev,
 		}
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, &configs, &nconfigs);
+	ret =3D pinconf_generic_parse_dt_config(np, pctldev, &configs, &nconfigs);
 	if (nconfigs) {
 		const char *gpio_name;
 		const char *pin;
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-ge=
neric.c
index 21b3d90ebb2d..e0886665b70a 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -27,17 +27,6 @@
 #include "pinctrl-utils.h"
=20
 #ifdef CONFIG_DEBUG_FS
-
-struct pin_config_item {
-	const enum pin_config_param param;
-	const char * const display;
-	const char * const format;
-	bool has_arg;
-};
-
-#define PCONFDUMP(a, b, c, d) { .param =3D a, .display =3D b, .format =3D =
c, \
-				.has_arg =3D d }
-
 static const struct pin_config_item conf_items[] =3D {
 	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NU=
LL, false),
@@ -60,22 +49,25 @@ static const struct pin_config_item conf_items[] =3D {
 	PCONFDUMP(PIN_CONFIG_OUTPUT, "pin output", "level", true),
 };
=20
-void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
-			      struct seq_file *s, unsigned pin)
+static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
+				     struct seq_file *s, const char *gname,
+				     unsigned pin,
+				     const struct pin_config_item *items,
+				     int nitems)
 {
-	const struct pinconf_ops *ops =3D pctldev->desc->confops;
 	int i;
=20
-	if (!ops->is_generic)
-		return;
-
-	for (i =3D 0; i < ARRAY_SIZE(conf_items); i++) {
+	for (i =3D 0; i < nitems; i++) {
 		unsigned long config;
 		int ret;
=20
 		/* We want to check out this parameter */
-		config =3D pinconf_to_config_packed(conf_items[i].param, 0);
-		ret =3D pin_config_get_for_pin(pctldev, pin, &config);
+		config =3D pinconf_to_config_packed(items[i].param, 0);
+		if (gname)
+			ret =3D pin_config_group_get(dev_name(pctldev->dev),
+						   gname, &config);
+		else
+			ret =3D pin_config_get_for_pin(pctldev, pin, &config);
 		/* These are legal errors */
 		if (ret =3D -EINVAL || ret =3D -ENOTSUPP)
 			continue;
@@ -85,56 +77,46 @@ void pinconf_generic_dump_pin(struct pinctrl_dev *pctld=
ev,
 		}
 		/* Space between multiple configs */
 		seq_puts(s, " ");
-		seq_puts(s, conf_items[i].display);
+		seq_puts(s, items[i].display);
 		/* Print unit if available */
-		if (conf_items[i].has_arg) {
+		if (items[i].has_arg) {
 			seq_printf(s, " (%u",
 				   pinconf_to_config_argument(config));
-			if (conf_items[i].format)
-				seq_printf(s, " %s)", conf_items[i].format);
+			if (items[i].format)
+				seq_printf(s, " %s)", items[i].format);
 			else
 				seq_puts(s, ")");
 		}
 	}
 }
=20
-void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
-			      struct seq_file *s, const char *gname)
+/**
+ * pinconf_generic_dump_pins - Print information about pin or group of pins
+ * @pctldev:	Pincontrol device
+ * @s:		File to print to
+ * @gname:	Group name specifying pins
+ * @pin:	Pin number specyfying pin
+ *
+ * Print the pinconf configuration for the requested pin(s) to @s. Pins ca=
n be
+ * specified either by pin using @pin or by group using @gname. Only one n=
eeds
+ * to be specified the other can be NULL/0.
+ */
+void pinconf_generic_dump_pins(struct pinctrl_dev *pctldev, struct seq_fil=
e *s,
+			       const char *gname, unsigned pin)
 {
 	const struct pinconf_ops *ops =3D pctldev->desc->confops;
-	int i;
=20
 	if (!ops->is_generic)
 		return;
=20
-	for (i =3D 0; i < ARRAY_SIZE(conf_items); i++) {
-		unsigned long config;
-		int ret;
-
-		/* We want to check out this parameter */
-		config =3D pinconf_to_config_packed(conf_items[i].param, 0);
-		ret =3D pin_config_group_get(dev_name(pctldev->dev), gname,
-					   &config);
-		/* These are legal errors */
-		if (ret =3D -EINVAL || ret =3D -ENOTSUPP)
-			continue;
-		if (ret) {
-			seq_printf(s, "ERROR READING CONFIG SETTING %d ", i);
-			continue;
-		}
-		/* Space between multiple configs */
-		seq_puts(s, " ");
-		seq_puts(s, conf_items[i].display);
-		/* Print unit if available */
-		if (conf_items[i].has_arg) {
-			seq_printf(s, " (%u",
-				   pinconf_to_config_argument(config));
-			if (conf_items[i].format)
-				seq_printf(s, " %s)", conf_items[i].format);
-			else
-				seq_puts(s, ")");
-		}
-	}
+	/* generic parameters */
+	pinconf_generic_dump_one(pctldev, s, gname, pin, conf_items,
+				 ARRAY_SIZE(conf_items));
+	/* driver-specific parameters */
+	if (pctldev->desc->num_dt_params && pctldev->desc->conf_items)
+		pinconf_generic_dump_one(pctldev, s, gname, pin,
+					 pctldev->desc->conf_items,
+					 pctldev->desc->num_dt_params);
 }
=20
 void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
@@ -148,17 +130,21 @@ void pinconf_generic_dump_config(struct pinctrl_dev *=
pctldev,
 		seq_printf(s, "%s: 0x%x", conf_items[i].display,
 			   pinconf_to_config_argument(config));
 	}
+
+	if (!pctldev->desc->num_dt_params || !pctldev->desc->conf_items)
+		return;
+
+	for (i =3D 0; i < pctldev->desc->num_dt_params; i++) {
+		if (pinconf_to_config_param(config) !=3D pctldev->desc->conf_items[i].pa=
ram)
+			continue;
+		seq_printf(s, "%s: 0x%x", pctldev->desc->conf_items[i].display,
+			   pinconf_to_config_argument(config));
+	}
 }
 EXPORT_SYMBOL_GPL(pinconf_generic_dump_config);
 #endif
=20
 #ifdef CONFIG_OF
-struct pinconf_generic_dt_params {
-	const char * const property;
-	enum pin_config_param param;
-	u32 default_value;
-};
-
 static const struct pinconf_generic_dt_params dt_params[] =3D {
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
@@ -184,6 +170,47 @@ static const struct pinconf_generic_dt_params dt_param=
s[] =3D {
 };
=20
 /**
+ * parse_dt_cfg - Parse DT pinconf parameters
+ * @np:	DT node
+ * @params:	Array of describing DT parameters
+ * @count:	Number of entries in @params
+ * @cfg:	Array of parsed config options
+ * @ncfg:	Number of entries in @cfg
+ *
+ * Parse the config options described in @params from @np and puts the res=
ult
+ * in @cfg. @cfg does not need to be empty, entries are added beggining at
+ * @ncfg. @ncfg is updated to reflect the number of entries after parsing.=
 @cfg
+ * needs to have enough memory allocated to hold all possible entries.
+ */
+static void parse_dt_cfg(struct device_node *np,
+			 const struct pinconf_generic_dt_params *params,
+			 unsigned int count, unsigned long *cfg,
+			 unsigned int *ncfg)
+{
+	int i;
+
+	for (i =3D 0; i < count; i++) {
+		u32 val;
+		int ret;
+		const struct pinconf_generic_dt_params *par =3D &params[i];
+
+		ret =3D of_property_read_u32(np, par->property, &val);
+
+		/* property not found */
+		if (ret =3D -EINVAL)
+			continue;
+
+		/* use default value, when no value is specified */
+		if (ret)
+			val =3D par->default_value;
+
+		pr_debug("found %s with value %u\n", par->property, val);
+		cfg[*ncfg] =3D pinconf_to_config_packed(par->param, val);
+		(*ncfg)++;
+	}
+}
+
+/**
  * pinconf_generic_parse_dt_config()
  * parse the config properties into generic pinconfig values.
  * @np: node containing the pinconfig properties
@@ -191,39 +218,29 @@ static const struct pinconf_generic_dt_params dt_para=
ms[] =3D {
  * @nconfigs: umber of configurations
  */
 int pinconf_generic_parse_dt_config(struct device_node *np,
+				    struct pinctrl_dev *pctldev,
 				    unsigned long **configs,
 				    unsigned int *nconfigs)
 {
 	unsigned long *cfg;
-	unsigned int ncfg =3D 0;
+	unsigned int max_cfg, ncfg =3D 0;
 	int ret;
-	int i;
-	u32 val;
=20
 	if (!np)
 		return -EINVAL;
=20
 	/* allocate a temporary array big enough to hold one of each option */
-	cfg =3D kzalloc(sizeof(*cfg) * ARRAY_SIZE(dt_params), GFP_KERNEL);
+	max_cfg =3D ARRAY_SIZE(dt_params);
+	if (pctldev)
+		max_cfg +=3D pctldev->desc->num_dt_params;
+	cfg =3D kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return -ENOMEM;
=20
-	for (i =3D 0; i < ARRAY_SIZE(dt_params); i++) {
-		const struct pinconf_generic_dt_params *par =3D &dt_params[i];
-		ret =3D of_property_read_u32(np, par->property, &val);
-
-		/* property not found */
-		if (ret =3D -EINVAL)
-			continue;
-
-		/* use default value, when no value is specified */
-		if (ret)
-			val =3D par->default_value;
-
-		pr_debug("found %s with value %u\n", par->property, val);
-		cfg[ncfg] =3D pinconf_to_config_packed(par->param, val);
-		ncfg++;
-	}
+	parse_dt_cfg(np, dt_params, ARRAY_SIZE(dt_params), cfg, &ncfg);
+	if (pctldev && pctldev->desc->num_dt_params && pctldev->desc->params)
+		parse_dt_cfg(np, pctldev->desc->params,
+			      pctldev->desc->num_dt_params, cfg, &ncfg);
=20
 	ret =3D 0;
=20
@@ -274,7 +291,8 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_de=
v *pctldev,
 		function =3D NULL;
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, &configs, &num_configs);
+	ret =3D pinconf_generic_parse_dt_config(np, pctldev, &configs,
+					      &num_configs);
 	if (ret < 0) {
 		dev_err(dev, "could not parse node property\n");
 		return ret;
diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 8bfa0643e5dc..1fc09dc20199 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -288,7 +288,7 @@ static void pinconf_dump_pin(struct pinctrl_dev *pctlde=
v,
 	const struct pinconf_ops *ops =3D pctldev->desc->confops;
=20
 	/* no-op when not using generic pin config */
-	pinconf_generic_dump_pin(pctldev, s, pin);
+	pinconf_generic_dump_pins(pctldev, s, NULL, pin);
 	if (ops && ops->pin_config_dbg_show)
 		ops->pin_config_dbg_show(pctldev, s, pin);
 }
@@ -333,7 +333,7 @@ static void pinconf_dump_group(struct pinctrl_dev *pctl=
dev,
 	const struct pinconf_ops *ops =3D pctldev->desc->confops;
=20
 	/* no-op when not using generic pin config */
-	pinconf_generic_dump_group(pctldev, s, gname);
+	pinconf_generic_dump_pins(pctldev, s, gname, 0);
 	if (ops && ops->pin_config_group_dbg_show)
 		ops->pin_config_group_dbg_show(pctldev, s, selector);
 }
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index a4a5417e1413..55c75780b3b2 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -92,26 +92,17 @@ static inline void pinconf_init_device_debugfs(struct d=
entry *devroot,
=20
 #if defined(CONFIG_GENERIC_PINCONF) && defined(CONFIG_DEBUG_FS)
=20
-void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
-			      struct seq_file *s, unsigned pin);
-
-void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
-			      struct seq_file *s, const char *gname);
+void pinconf_generic_dump_pins(struct pinctrl_dev *pctldev,
+			       struct seq_file *s, const char *gname,
+			       unsigned pin);
=20
 void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
 				 struct seq_file *s, unsigned long config);
 #else
=20
-static inline void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
-					    struct seq_file *s,
-					    unsigned pin)
-{
-	return;
-}
-
-static inline void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
-					      struct seq_file *s,
-					      const char *gname)
+static inline void pinconf_generic_dump_pins(struct pinctrl_dev *pctldev,
+					     struct seq_file *s,
+					     const char *gname, unsigned pin)
 {
 	return;
 }
@@ -126,6 +117,7 @@ static inline void pinconf_generic_dump_config(struct p=
inctrl_dev *pctldev,
=20
 #if defined(CONFIG_GENERIC_PINCONF) && defined(CONFIG_OF)
 int pinconf_generic_parse_dt_config(struct device_node *np,
+				    struct pinctrl_dev *pctldev,
 				    unsigned long **configs,
 				    unsigned int *nconfigs);
 #endif
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-r=
ockchip.c
index 40970c305dd0..a72fe6faa392 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1140,7 +1140,7 @@ static int rockchip_pinctrl_parse_groups(struct devic=
e_node *np,
 			return -EINVAL;
=20
 		np_config =3D of_find_node_by_phandle(be32_to_cpup(phandle));
-		ret =3D pinconf_generic_parse_dt_config(np_config,
+		ret =3D pinconf_generic_parse_dt_config(np_config, NULL,
 				&grp->data[j].configs, &grp->data[j].nconfigs);
 		if (ret)
 			return ret;
diff --git a/drivers/pinctrl/pinctrl-tz1090-pdc.c b/drivers/pinctrl/pinctrl=
-tz1090-pdc.c
index 3bb6a3b78864..0e3576ba1a7c 100644
--- a/drivers/pinctrl/pinctrl-tz1090-pdc.c
+++ b/drivers/pinctrl/pinctrl-tz1090-pdc.c
@@ -415,7 +415,7 @@ static int tz1090_pdc_pinctrl_dt_subnode_to_map(struct =
device *dev,
 		function =3D NULL;
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, &configs, &num_configs);
+	ret =3D pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/pinctrl/pinctrl-tz1090.c b/drivers/pinctrl/pinctrl-tz1=
090.c
index 48d36413b99f..0b36566db451 100644
--- a/drivers/pinctrl/pinctrl-tz1090.c
+++ b/drivers/pinctrl/pinctrl-tz1090.c
@@ -1131,7 +1131,7 @@ static int tz1090_pinctrl_dt_subnode_to_map(struct de=
vice *dev,
 		function =3D NULL;
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, &configs, &num_configs);
+	ret =3D pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinc=
trl.c
index 910deaefa0ac..072e7c62cab7 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -122,7 +122,7 @@ static int sh_pfc_dt_subnode_to_map(struct device *dev,=
 struct device_node *np,
 		return ret;
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, &configs, &num_configs);
+	ret =3D pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs);
 	if (ret < 0)
 		return ret;
=20
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctr=
l/pinconf-generic.h
index 83c89f5ab705..342409f7f3ec 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -115,6 +115,18 @@ enum pin_config_param {
 	PIN_CONFIG_END =3D 0x7FFF,
 };
=20
+#ifdef CONFIG_DEBUG_FS
+#define PCONFDUMP(a, b, c, d) { .param =3D a, .display =3D b, .format =3D =
c, \
+				.has_arg =3D d }
+
+struct pin_config_item {
+	const enum pin_config_param param;
+	const char * const display;
+	const char * const format;
+	bool has_arg;
+};
+#endif /* CONFIG_DEBUG_FS */
+
 /*
  * Helpful configuration macro to be used in tables etc.
  */
@@ -150,6 +162,12 @@ static inline unsigned long pinconf_to_config_packed(e=
num pin_config_param param
 struct pinctrl_dev;
 struct pinctrl_map;
=20
+struct pinconf_generic_dt_params {
+	const char * const property;
+	enum pin_config_param param;
+	u32 default_value;
+};
+
 int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
 		unsigned *reserved_maps, unsigned *num_maps,
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctr=
l.h
index cc8e1aff0e28..c58b3e11ba8e 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -24,6 +24,7 @@ struct pinctrl_dev;
 struct pinctrl_map;
 struct pinmux_ops;
 struct pinconf_ops;
+struct pin_config_item;
 struct gpio_chip;
 struct device_node;
=20
@@ -117,6 +118,9 @@ struct pinctrl_ops {
  * @confops: pin config operations vtable, if you support pin configuratio=
n in
  *	your driver
  * @owner: module providing the pin controller, used for refcounting
+ * @num_dt_params: Number of driver-specific DT parameters
+ * @params: List of DT parameters
+ * @conf_items: Information how to print @params in debugfs
  */
 struct pinctrl_desc {
 	const char *name;
@@ -126,6 +130,11 @@ struct pinctrl_desc {
 	const struct pinmux_ops *pmxops;
 	const struct pinconf_ops *confops;
 	struct module *owner;
+#if defined(CONFIG_GENERIC_PINCONF) && defined(CONFIG_OF)
+	unsigned int num_dt_params;
+	const struct pinconf_generic_dt_params *params;
+	const struct pin_config_item *conf_items;
+#endif
 };
=20
 /* External interface to pin controller */
--=20
2.2.0.1.g9ee0458

