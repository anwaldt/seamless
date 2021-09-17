{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 1,
			"revision" : 11,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 34.0, 87.0, 934.0, 558.0 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 1,
							"revision" : 11,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 59.0, 104.0, 739.0, 534.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"assistshowspatchername" : 0,
						"visible" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-43",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 55.0, 249.0, 58.0, 22.0 ],
									"text" : "loadbang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-42",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 8,
											"minor" : 1,
											"revision" : 11,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"classnamespace" : "box",
										"rect" : [ 0.0, 0.0, 640.0, 480.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"assistshowspatchername" : 0,
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-39",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 243.75, 444.5, 39.0, 22.0 ],
													"text" : "$2 $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-37",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 191.5, 187.0, 29.5, 22.0 ],
													"text" : "+ 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-32",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 243.75, 419.0, 37.0, 22.0 ],
													"text" : "join 2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-31",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 50.0, 384.0, 175.0, 22.0 ],
													"text" : "sprintf /source/%i/vumeter/level"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-30",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 243.75, 470.0, 76.0, 22.0 ],
													"text" : "prepend rule"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-28",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 213.5, 214.0, 29.5, 22.0 ],
													"text" : "+ 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-25",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "int", "int", "int" ],
													"patching_rect" : [ 195.5, 148.0, 143.0, 22.0 ],
													"text" : "t i i i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-24",
													"maxclass" : "number",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "bang" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 145.5, 247.0, 50.0, 22.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-22",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 248.5, 254.0, 29.5, 22.0 ],
													"text" : "+ 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-21",
													"maxclass" : "number",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "bang" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 248.5, 279.0, 50.0, 22.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-17",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 247.5, 223.0, 29.5, 22.0 ],
													"text" : "% 2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-16",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 84.5, 247.0, 42.0, 22.0 ],
													"text" : "gate 2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-15",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"patching_rect" : [ 116.5, 203.0, 29.5, 22.0 ],
													"text" : "t i i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 245.5, 303.0, 124.0, 22.0 ],
													"text" : "sprintf /1/level%iRight"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 98.5, 303.0, 116.0, 22.0 ],
													"text" : "sprintf /1/level%iLeft"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 221.5, 183.0, 29.5, 22.0 ],
													"text" : "/ 2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "bang", "int" ],
													"patching_rect" : [ 155.5, 100.0, 51.0, 22.0 ],
													"text" : "uzi 32 0"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-40",
													"index" : 1,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 155.5, 40.0, 30.0, 30.0 ]
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-41",
													"index" : 1,
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 243.75, 552.0, 30.0, 30.0 ]
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-32", 1 ],
													"source" : [ "obj-14", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-16", 1 ],
													"source" : [ "obj-15", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"source" : [ "obj-16", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"source" : [ "obj-16", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-22", 0 ],
													"source" : [ "obj-17", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-16", 0 ],
													"order" : 1,
													"source" : [ "obj-22", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-21", 0 ],
													"order" : 0,
													"source" : [ "obj-22", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-17", 0 ],
													"source" : [ "obj-25", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-37", 0 ],
													"source" : [ "obj-25", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"source" : [ "obj-25", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"source" : [ "obj-28", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-25", 0 ],
													"source" : [ "obj-3", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-41", 0 ],
													"source" : [ "obj-30", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-32", 0 ],
													"source" : [ "obj-31", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-39", 0 ],
													"source" : [ "obj-32", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 0 ],
													"source" : [ "obj-37", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-30", 0 ],
													"source" : [ "obj-39", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-28", 0 ],
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"source" : [ "obj-40", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-32", 1 ],
													"source" : [ "obj-5", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 77.5, 366.0, 65.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"tags" : ""
									}
,
									"text" : "p setRules"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-36",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 145.0, 409.0, 35.0, 22.0 ],
									"text" : "clear"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-34",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 77.5, 301.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-29",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"patching_rect" : [ 145.0, 498.0, 103.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0
									}
,
									"text" : "spat5.osc.replace"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 470.0, 514.0, 29.5, 22.0 ],
									"text" : "+ 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 388.0, 522.0, 50.0, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 452.0, 481.0, 29.5, 22.0 ],
									"text" : "/ 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 452.0, 429.0, 29.5, 22.0 ],
									"text" : "1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 344.0, 334.0, 100.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 533.0, 103.0, 97.0, 22.0 ],
									"text" : "udpreceive 9004"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-34", 0 ],
									"source" : [ "obj-43", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"order" : 0,
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 1 ],
									"order" : 1,
									"source" : [ "obj-7", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 538.0, 590.0, 59.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p tmInput"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-44",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 155.0, 72.0, 50.0, 22.0 ],
					"text" : "select 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-45",
					"maxclass" : "textbutton",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 48.0, 157.0, 100.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 32.0, 20.0, 100.0, 20.0 ],
					"text" : "viewControl",
					"texton" : "viewControl"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-46",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 197.0, 187.0, 83.0, 22.0 ],
					"text" : "/window/close"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-47",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 159.0, 157.0, 82.0, 22.0 ],
					"text" : "/window/open"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-43",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 815.0, 138.0, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 38.0, 106.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-41",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 888.0, 247.0, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 38.0, 133.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-35",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 969.0, 167.0, 59.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 116.5, 133.0, 59.0, 22.0 ],
					"text" : "127.0.0.1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-34",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 933.0, 102.0, 252.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 96.0, 106.0, 85.0, 22.0 ],
					"text" : "172.25.18.201"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-109",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 1,
							"revision" : 11,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 404.0, 394.0, 1002.0, 472.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-70",
									"index" : 1,
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 116.0, 38.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-69",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 737.0, 126.0, 48.0, 22.0 ],
									"text" : "host $1"
								}

							}
, 							{
								"box" : 								{
									"comment" : "setHost",
									"id" : "obj-63",
									"index" : 3,
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 744.0, 58.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-49",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 287.5, 54.0, 50.0, 22.0 ],
									"text" : "select 1"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-45",
									"index" : 2,
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 287.5, 10.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-39",
									"index" : 1,
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 641.0, 387.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 372.5, 58.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-76",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 279.61164665222168, 874.757269561290741, 58.0, 22.0 ],
									"text" : "set $2 $3"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-74",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 274.0, 764.009698688983917, 117.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.unslashify"
								}

							}
, 							{
								"box" : 								{
									"candycane" : 10,
									"ghostbar" : 44,
									"id" : "obj-73",
									"maxclass" : "multislider",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 274.0, 953.737863957881927, 203.456315457820892, 114.262136042118073 ],
									"setminmax" : [ 0.0, 1.0 ],
									"setstyle" : 1,
									"size" : 12
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-68",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 476.0, 768.0, 50.0, 22.0 ],
									"text" : "set 1."
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-64",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 524.0, 1041.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-51",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 436.0, 1027.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-47",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 395.0, 764.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-43",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 546.430199430199423, 875.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-41",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 942.736860513687134, 655.368421316146851, 58.0, 22.0 ],
									"text" : "$1 set $2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 118.0, 865.0, 104.0, 22.0 ],
									"text" : "/source/1/ambi $1"
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-33",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 106.0, 686.125, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 106.0, 940.0, 135.0, 22.0 ],
									"text" : "udpsend localhost 4455"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 11,
									"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "" ],
									"patching_rect" : [ 1249.0, 691.0, 231.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.route /1 /2 /3 /4 /5 /6 /7 /8 /9 /10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 980.930199430199423, 617.25, 93.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.trim 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-72",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 630.0, 352.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-66",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 546.430199430199423, 673.25, 58.0, 22.0 ],
									"text" : "$1 set $2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-65",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 432.0, 686.125, 58.0, 22.0 ],
									"text" : "$1 set $2"
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-53",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1195.145299145299077, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-54",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1143.240265906932564, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-55",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1091.33523266856605, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-56",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1039.430199430199536, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-57",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 987.525166191832909, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-58",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 935.620132953466282, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-59",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 883.715099715099768, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-60",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 831.810066476733141, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-61",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 779.905033238366514, 768.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-62",
									"knobcolor" : [ 0.125490196078431, 1.0, 0.168627450980392, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 476.0, 875.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-52",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1173.145299145299077, 869.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-50",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1121.240265906932564, 861.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-48",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1069.33523266856605, 847.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-46",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1017.430199430199536, 861.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-44",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 965.525166191832909, 851.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-42",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 913.620132953466282, 839.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-40",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 861.715099715099768, 822.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-38",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 805.810066476733141, 851.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-36",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 759.905033238366514, 811.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-34",
									"knobcolor" : [ 1.0, 0.125490196078431, 0.125490196078431, 1.0 ],
									"maxclass" : "slider",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 705.0, 797.0, 20.0, 140.0 ],
									"size" : 1.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-32",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 11,
									"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "" ],
									"patching_rect" : [ 987.0, 691.0, 231.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.route /1 /2 /3 /4 /5 /6 /7 /8 /9 /10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 801.0, 602.686893403530121, 93.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.trim 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-30",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 705.0, 617.25, 93.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.trim 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"patching_rect" : [ 705.0, 543.5, 189.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.route /wfs /ambi /reverb"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 8.0, 628.0, 79.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.flip"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 11,
									"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "" ],
									"patching_rect" : [ 705.0, 691.0, 231.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.route /1 /2 /3 /4 /5 /6 /7 /8 /9 /10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 432.0, 554.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"linecount" : 2,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 245.0, 635.0, 50.0, 35.0 ],
									"text" : "/ping 4999"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"patching_rect" : [ 8.0, 576.0, 190.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.route /source /oscrouter"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-29",
									"maxclass" : "toggle",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 118.0, 390.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-27",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 167.0, 409.0, 52.0, 22.0 ],
									"text" : "gate 1 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-26",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 125.0, 492.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-21",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 240.0, 228.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 315.0, 468.0, 105.0, 22.0 ],
									"text" : "host 172.23.23.6"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-15",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 209.0, 341.0, 48.0, 22.0 ],
									"text" : "host $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 205.0, 518.0, 165.0, 22.0 ],
									"text" : "udpsend 172.25.18.201 4999"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 125.0, 281.0, 154.0, 22.0 ],
									"text" : "/oscrouter/pong maxViewer"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"patching_rect" : [ 114.5, 223.0, 29.5, 22.0 ],
									"text" : "t l b"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 48.0, 281.0, 50.0, 22.0 ],
									"text" : "4999"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"patching_rect" : [ 116.0, 174.0, 205.0, 22.0 ],
									"text" : "route /oscrouter/ping /oscrouter/pong"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 372.5, 97.0, 266.0, 22.0 ],
									"text" : "/oscrouter/subscribe maxViewer 55551 xyz 1 20"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 41.0, 244.0, 32.0, 22.0 ],
									"text" : "print"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 382.0, 150.0, 124.0, 22.0 ],
									"text" : "/oscrouter/ping 55511"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 377.0, 341.0, 178.0, 22.0 ],
									"text" : "udpsend 255.255.255.255 4999"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 1 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"source" : [ "obj-11", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-27", 1 ],
									"order" : 1,
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-72", 0 ],
									"order" : 0,
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"order" : 1,
									"source" : [ "obj-15", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 1 ],
									"order" : 0,
									"source" : [ "obj-15", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-34", 0 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"source" : [ "obj-20", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"source" : [ "obj-20", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-40", 0 ],
									"source" : [ "obj-20", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"source" : [ "obj-20", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-44", 0 ],
									"source" : [ "obj-20", 5 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-46", 0 ],
									"source" : [ "obj-20", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-48", 0 ],
									"source" : [ "obj-20", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-50", 0 ],
									"source" : [ "obj-20", 8 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-52", 0 ],
									"source" : [ "obj-20", 9 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"order" : 0,
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"order" : 1,
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-30", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 0 ],
									"order" : 0,
									"source" : [ "obj-28", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"source" : [ "obj-28", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-74", 0 ],
									"order" : 1,
									"source" : [ "obj-28", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-27", 0 ],
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 1 ],
									"source" : [ "obj-3", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 1 ],
									"source" : [ "obj-3", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-30", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-41", 0 ],
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-43", 0 ],
									"order" : 0,
									"source" : [ "obj-32", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-53", 0 ],
									"source" : [ "obj-32", 9 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-54", 0 ],
									"source" : [ "obj-32", 8 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-55", 0 ],
									"source" : [ "obj-32", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-56", 0 ],
									"source" : [ "obj-32", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-57", 0 ],
									"source" : [ "obj-32", 5 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-58", 0 ],
									"source" : [ "obj-32", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-59", 0 ],
									"source" : [ "obj-32", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-60", 0 ],
									"source" : [ "obj-32", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-61", 0 ],
									"source" : [ "obj-32", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-62", 0 ],
									"order" : 2,
									"source" : [ "obj-32", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-68", 1 ],
									"order" : 1,
									"source" : [ "obj-32", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"source" : [ "obj-33", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-37", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-32", 0 ],
									"source" : [ "obj-41", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-64", 0 ],
									"source" : [ "obj-43", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"order" : 1,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-49", 0 ],
									"order" : 0,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-49", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-51", 0 ],
									"source" : [ "obj-62", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-69", 0 ],
									"source" : [ "obj-63", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-62", 0 ],
									"source" : [ "obj-68", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-69", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"source" : [ "obj-70", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 0 ],
									"source" : [ "obj-72", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-76", 0 ],
									"source" : [ "obj-74", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-73", 0 ],
									"source" : [ "obj-76", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"source" : [ "obj-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"order" : 1,
									"source" : [ "obj-8", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"order" : 0,
									"source" : [ "obj-8", 1 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 795.0, 208.0, 112.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p oscRSubscription"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 583.0, 354.0, 50.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 38.0, 164.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 614.0, 286.0, 113.0, 22.0 ],
					"text" : "ps-packageCounter"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-40",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 172.0, 274.0, 50.0, 22.0 ],
					"text" : "select 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-39",
					"maxclass" : "textbutton",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 164.0, 240.0, 100.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 38.0, 59.0, 100.0, 20.0 ],
					"text" : "viewer",
					"texton" : "viewer"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-38",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 214.0, 500.0, 19.0, 22.0 ],
					"text" : "t l"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-37",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 214.0, 389.0, 83.0, 22.0 ],
					"text" : "/window/close"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-32",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 176.0, 359.0, 82.0, 22.0 ],
					"text" : "/window/open"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-30",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 611.0, 431.0, 29.5, 22.0 ],
					"text" : "t l l"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 491.0, 724.0, 19.0, 22.0 ],
					"text" : "t l"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
					"linecount" : 2,
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 1023.0, 267.5, 236.0, 35.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "spat5.viewer @initwith \"/source/number 1, /format xyz\""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 825.0, 636.0, 164.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "spat5.osc.append /proportion"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-23",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 825.0, 670.0, 214.0, 22.0 ],
					"text" : "join 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-22",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 492.0, 670.0, 214.0, 22.0 ],
					"text" : "join 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 115.0, 455.0, 44.0, 22.0 ],
					"text" : "/status"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 857.0, 581.0, 124.0, 22.0 ],
					"text" : "scale -10. 10 70. 300."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "float" ],
					"patching_rect" : [ 768.0, 534.0, 29.5, 22.0 ],
					"text" : "t f f"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 623.0, 529.0, 31.0, 22.0 ],
					"text" : "t s s"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 768.0, 487.0, 29.5, 22.0 ],
					"text" : "$3"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 687.0, 636.0, 118.0, 22.0 ],
					"text" : "scale -10. 10. -60. 6."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 687.0, 453.0, 55.0, 22.0 ],
					"text" : "zl.slice 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 492.0, 636.0, 181.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "spat5.osc.append /vumeter/level"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 623.0, 491.0, 97.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "spat5.osc.trim -1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 631.0, 380.0, 188.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "spat5.osc.routepass /source/*/xyz"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 638.0, 157.0, 104.0, 22.0 ],
					"text" : "udpreceive 55551"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 567.0, 92.0, 44.0, 22.0 ],
					"text" : "/status"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 408.5, 325.0, 109.0, 22.0 ],
					"text" : "/speaker/number 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-145",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 451.0, 59.0, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 148.0, 20.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-143",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 435.0, 92.0, 111.0, 22.0 ],
					"text" : "/window/floating $1"
				}

			}
, 			{
				"box" : 				{
					"data" : 					{
						"/source/number" : 32,
						"/source/1/label" : "1",
						"/source/1/color" : [ 1.0, 0.0, 0.0, 1.0 ],
						"/source/1/visible" : 1,
						"/source/1/editable" : 1,
						"/source/2/label" : "2",
						"/source/2/color" : [ 1.0, 0.400000005960464, 0.0, 1.0 ],
						"/source/2/visible" : 1,
						"/source/2/editable" : 1,
						"/source/3/label" : "3",
						"/source/3/color" : [ 1.0, 0.796078443527222, 0.0, 1.0 ],
						"/source/3/visible" : 1,
						"/source/3/editable" : 1,
						"/source/4/label" : "4",
						"/source/4/color" : [ 0.803921580314636, 1.0, 0.0, 1.0 ],
						"/source/4/visible" : 1,
						"/source/4/editable" : 1,
						"/source/5/label" : "5",
						"/source/5/color" : [ 0.407843142747879, 1.0, 0.0, 1.0 ],
						"/source/5/visible" : 1,
						"/source/5/editable" : 1,
						"/source/6/label" : "6",
						"/source/6/color" : [ 0.007843137718737, 1.0, 0.0, 1.0 ],
						"/source/6/visible" : 1,
						"/source/6/editable" : 1,
						"/source/7/label" : "7",
						"/source/7/color" : [ 0.0, 1.0, 0.39215686917305, 1.0 ],
						"/source/7/visible" : 1,
						"/source/7/editable" : 1,
						"/source/8/label" : "8",
						"/source/8/color" : [ 0.0, 1.0, 0.788235306739807, 1.0 ],
						"/source/8/visible" : 1,
						"/source/8/editable" : 1,
						"/source/9/label" : "9",
						"/source/9/color" : [ 0.0, 0.811764717102051, 1.0, 1.0 ],
						"/source/9/visible" : 1,
						"/source/9/editable" : 1,
						"/source/10/label" : "10",
						"/source/10/color" : [ 0.0, 0.415686279535294, 1.0, 1.0 ],
						"/source/10/visible" : 1,
						"/source/10/editable" : 1,
						"/source/11/label" : "11",
						"/source/11/color" : [ 0.0, 0.015686275437474, 1.0, 1.0 ],
						"/source/11/visible" : 1,
						"/source/11/editable" : 1,
						"/source/12/label" : "12",
						"/source/12/color" : [ 0.384313732385635, 0.0, 1.0, 1.0 ],
						"/source/12/visible" : 1,
						"/source/12/editable" : 1,
						"/source/13/label" : "13",
						"/source/13/color" : [ 0.780392169952393, 0.0, 1.0, 1.0 ],
						"/source/13/visible" : 1,
						"/source/13/editable" : 1,
						"/source/14/label" : "14",
						"/source/14/color" : [ 1.0, 0.0, 0.819607853889465, 1.0 ],
						"/source/14/visible" : 1,
						"/source/14/editable" : 1,
						"/source/15/label" : "15",
						"/source/15/color" : [ 1.0, 0.0, 0.423529416322708, 1.0 ],
						"/source/15/visible" : 1,
						"/source/15/editable" : 1,
						"/source/16/label" : "16",
						"/source/16/color" : [ 1.0, 0.0, 0.023529412224889, 1.0 ],
						"/source/16/visible" : 1,
						"/source/16/editable" : 1,
						"/source/17/label" : "17",
						"/source/17/color" : [ 0.0, 0.0, 0.513725519180298, 1.0 ],
						"/source/17/visible" : 0,
						"/source/17/editable" : 1,
						"/source/18/label" : "18",
						"/source/18/color" : [ 0.0, 0.0, 0.780392169952393, 1.0 ],
						"/source/18/visible" : 0,
						"/source/18/editable" : 1,
						"/source/19/label" : "19",
						"/source/19/color" : [ 0.0, 0.047058824449778, 1.0, 1.0 ],
						"/source/19/visible" : 1,
						"/source/19/editable" : 1,
						"/source/20/label" : "20",
						"/source/20/color" : [ 0.0, 0.313725501298904, 1.0, 1.0 ],
						"/source/20/visible" : 1,
						"/source/20/editable" : 1,
						"/source/21/label" : "21",
						"/source/21/color" : [ 0.0, 0.576470613479614, 1.0, 1.0 ],
						"/source/21/visible" : 1,
						"/source/21/editable" : 1,
						"/source/22/label" : "22",
						"/source/22/color" : [ 0.0, 0.843137264251709, 1.0, 1.0 ],
						"/source/22/visible" : 1,
						"/source/22/editable" : 1,
						"/source/23/label" : "23",
						"/source/23/color" : [ 0.109803922474384, 1.0, 0.890196084976196, 1.0 ],
						"/source/23/visible" : 1,
						"/source/23/editable" : 1,
						"/source/24/label" : "24",
						"/source/24/color" : [ 0.376470595598221, 1.0, 0.623529434204102, 1.0 ],
						"/source/24/visible" : 1,
						"/source/24/editable" : 1,
						"/source/25/label" : "25",
						"/source/25/color" : [ 0.639215707778931, 1.0, 0.360784322023392, 1.0 ],
						"/source/25/visible" : 1,
						"/source/25/editable" : 1,
						"/source/26/label" : "26",
						"/source/26/color" : [ 0.905882358551025, 1.0, 0.094117648899555, 1.0 ],
						"/source/26/visible" : 1,
						"/source/26/editable" : 1,
						"/source/27/label" : "27",
						"/source/27/color" : [ 1.0, 0.82745099067688, 0.0, 1.0 ],
						"/source/27/visible" : 1,
						"/source/27/editable" : 1,
						"/source/28/label" : "28",
						"/source/28/color" : [ 1.0, 0.560784339904785, 0.0, 1.0 ],
						"/source/28/visible" : 1,
						"/source/28/editable" : 1,
						"/source/29/label" : "29",
						"/source/29/color" : [ 1.0, 0.298039227724075, 0.0, 1.0 ],
						"/source/29/visible" : 1,
						"/source/29/editable" : 1,
						"/source/30/label" : "30",
						"/source/30/color" : [ 1.0, 0.031372550874949, 0.0, 1.0 ],
						"/source/30/visible" : 1,
						"/source/30/editable" : 1,
						"/source/31/label" : "31",
						"/source/31/color" : [ 0.764705896377563, 0.0, 0.0, 1.0 ],
						"/source/31/visible" : 1,
						"/source/31/editable" : 1,
						"/source/32/label" : "31",
						"/source/32/color" : [ 0.501960813999176, 0.0, 0.0, 1.0 ],
						"/source/32/visible" : 1,
						"/source/32/editable" : 1,
						"/window/title" : "Viewer Control",
						"/window/visible" : 0,
						"/window/moveable" : 1,
						"/window/resizable" : 1,
						"/window/enable" : 1,
						"/window/bounds" : [ 149, 346, 310, 414 ],
						"/window/background/color" : [ 0.82745099067688, 0.82745099067688, 0.82745099067688, 1.0 ],
						"/window/opaque" : 1,
						"/window/titlebar" : 1,
						"/window/fullscreen" : 0,
						"/window/minimise" : 0,
						"/window/scale" : 100.0,
						"/window/rendering/engine" : "",
						"/window/rendering/fps/visible" : 0,
						"/window/floating" : 1,
						"/window/hidesondeactivate" : 0,
						"/window/buttons/close" : 1,
						"/window/buttons/minimise" : 1,
						"/window/buttons/maximise" : 1,
						"embed" : 1
					}
,
					"id" : "obj-136",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 347.166666666666629, 151.0, 177.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "spat5.viewer.control @embed 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-116",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 274.166666666666629, 770.5, 188.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "spat5.osc.routepass /source/*/xyz"
				}

			}
, 			{
				"box" : 				{
					"data" : 					{
						"/source/number" : 32,
						"/source/1/visible" : 1,
						"/source/1/editable" : 1,
						"/source/1/select" : 0,
						"/source/1/mute" : 0,
						"/source/1/hidewhenmute" : 0,
						"/source/1/aed" : [ -22.169065475463867, 0.316773593425751, 7.234948635101318 ],
						"/source/1/constraint/circular" : 0,
						"/source/1/coordinates/visible" : 1,
						"/source/1/orientation/mode" : "default",
						"/source/1/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/1/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/1/proportion" : 185.459991455078125,
						"/source/1/color" : [ 1.0, 0.0, 0.0, 1.0 ],
						"/source/1/image" : "",
						"/source/1/label" : "1",
						"/source/1/label/visible" : 1,
						"/source/1/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/1/label/justification" : "centred",
						"/source/1/vumeter/visible" : 1,
						"/source/1/vumeter/level" : -26.868000030517578,
						"/source/1/aperture" : 80.0,
						"/source/1/aperture/visible" : 0,
						"/source/1/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/1/radius" : 1.0,
						"/source/1/radius/visible" : 0,
						"/source/1/history/visible" : 0,
						"/source/1/history/size" : 100,
						"/source/1/history/color" : [ 1.0, 0.0, 0.0, 1.0 ],
						"/source/1/history/thickness" : 1.0,
						"/source/2/visible" : 1,
						"/source/2/editable" : 1,
						"/source/2/select" : 0,
						"/source/2/mute" : 0,
						"/source/2/hidewhenmute" : 0,
						"/source/2/aed" : [ 11.279189109802246, -0.391830503940582, 7.311381340026855 ],
						"/source/2/constraint/circular" : 0,
						"/source/2/coordinates/visible" : 1,
						"/source/2/orientation/mode" : "default",
						"/source/2/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/2/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/2/proportion" : 184.425018310546875,
						"/source/2/color" : [ 1.0, 0.400000005960464, 0.0, 1.0 ],
						"/source/2/image" : "",
						"/source/2/label" : "2",
						"/source/2/label/visible" : 1,
						"/source/2/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/2/label/justification" : "centred",
						"/source/2/vumeter/visible" : 1,
						"/source/2/vumeter/level" : -27.165000915527344,
						"/source/2/aperture" : 80.0,
						"/source/2/aperture/visible" : 0,
						"/source/2/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/2/radius" : 1.0,
						"/source/2/radius/visible" : 0,
						"/source/2/history/visible" : 0,
						"/source/2/history/size" : 100,
						"/source/2/history/color" : [ 1.0, 0.400000005960464, 0.0, 1.0 ],
						"/source/2/history/thickness" : 1.0,
						"/source/3/visible" : 1,
						"/source/3/editable" : 1,
						"/source/3/select" : 0,
						"/source/3/mute" : 0,
						"/source/3/hidewhenmute" : 0,
						"/source/3/aed" : [ 156.889129638671875, 15.149215698242188, 7.997437477111816 ],
						"/source/3/constraint/circular" : 0,
						"/source/3/coordinates/visible" : 1,
						"/source/3/orientation/mode" : "default",
						"/source/3/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/3/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/3/proportion" : 209.035003662109375,
						"/source/3/color" : [ 1.0, 0.796078443527222, 0.0, 1.0 ],
						"/source/3/image" : "",
						"/source/3/label" : "3",
						"/source/3/label/visible" : 1,
						"/source/3/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/3/label/justification" : "centred",
						"/source/3/vumeter/visible" : 1,
						"/source/3/vumeter/level" : -20.102998733520508,
						"/source/3/aperture" : 80.0,
						"/source/3/aperture/visible" : 0,
						"/source/3/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/3/radius" : 1.0,
						"/source/3/radius/visible" : 0,
						"/source/3/history/visible" : 0,
						"/source/3/history/size" : 100,
						"/source/3/history/color" : [ 1.0, 0.796078443527222, 0.0, 1.0 ],
						"/source/3/history/thickness" : 1.0,
						"/source/4/visible" : 1,
						"/source/4/editable" : 1,
						"/source/4/select" : 0,
						"/source/4/mute" : 0,
						"/source/4/hidewhenmute" : 0,
						"/source/4/aed" : [ 142.698867797851562, 11.443955421447754, 7.862531661987305 ],
						"/source/4/constraint/circular" : 0,
						"/source/4/coordinates/visible" : 1,
						"/source/4/orientation/mode" : "default",
						"/source/4/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/4/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/4/proportion" : 202.939971923828125,
						"/source/4/color" : [ 0.803921580314636, 1.0, 0.0, 1.0 ],
						"/source/4/image" : "",
						"/source/4/label" : "4",
						"/source/4/label/visible" : 1,
						"/source/4/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/4/label/justification" : "centred",
						"/source/4/vumeter/visible" : 1,
						"/source/4/vumeter/level" : -21.852001190185547,
						"/source/4/aperture" : 80.0,
						"/source/4/aperture/visible" : 0,
						"/source/4/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/4/radius" : 1.0,
						"/source/4/radius/visible" : 0,
						"/source/4/history/visible" : 0,
						"/source/4/history/size" : 100,
						"/source/4/history/color" : [ 0.803921580314636, 1.0, 0.0, 1.0 ],
						"/source/4/history/thickness" : 1.0,
						"/source/5/visible" : 1,
						"/source/5/editable" : 1,
						"/source/5/select" : 0,
						"/source/5/mute" : 0,
						"/source/5/hidewhenmute" : 0,
						"/source/5/aed" : [ 82.568641662597656, 16.793329238891602, 0.242280274629593 ],
						"/source/5/constraint/circular" : 0,
						"/source/5/coordinates/visible" : 1,
						"/source/5/orientation/mode" : "default",
						"/source/5/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/5/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/5/proportion" : 185.804977416992188,
						"/source/5/color" : [ 0.407843142747879, 1.0, 0.0, 1.0 ],
						"/source/5/image" : "",
						"/source/5/label" : "5",
						"/source/5/label/visible" : 1,
						"/source/5/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/5/label/justification" : "centred",
						"/source/5/vumeter/visible" : 1,
						"/source/5/vumeter/level" : -26.769001007080078,
						"/source/5/aperture" : 80.0,
						"/source/5/aperture/visible" : 0,
						"/source/5/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/5/radius" : 1.0,
						"/source/5/radius/visible" : 0,
						"/source/5/history/visible" : 0,
						"/source/5/history/size" : 100,
						"/source/5/history/color" : [ 0.407843142747879, 1.0, 0.0, 1.0 ],
						"/source/5/history/thickness" : 1.0,
						"/source/6/visible" : 1,
						"/source/6/editable" : 1,
						"/source/6/select" : 0,
						"/source/6/mute" : 0,
						"/source/6/hidewhenmute" : 0,
						"/source/6/aed" : [ 118.756340026855469, -0.292455404996872, 7.836541652679443 ],
						"/source/6/constraint/circular" : 0,
						"/source/6/coordinates/visible" : 1,
						"/source/6/orientation/mode" : "default",
						"/source/6/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/6/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/6/proportion" : 184.539993286132812,
						"/source/6/color" : [ 0.007843137718737, 1.0, 0.0, 1.0 ],
						"/source/6/image" : "",
						"/source/6/label" : "6",
						"/source/6/label/visible" : 1,
						"/source/6/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/6/label/justification" : "centred",
						"/source/6/vumeter/visible" : 1,
						"/source/6/vumeter/level" : -27.131999969482422,
						"/source/6/aperture" : 80.0,
						"/source/6/aperture/visible" : 0,
						"/source/6/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/6/radius" : 1.0,
						"/source/6/radius/visible" : 0,
						"/source/6/history/visible" : 0,
						"/source/6/history/size" : 100,
						"/source/6/history/color" : [ 0.007843137718737, 1.0, 0.0, 1.0 ],
						"/source/6/history/thickness" : 1.0,
						"/source/7/visible" : 1,
						"/source/7/editable" : 1,
						"/source/7/select" : 0,
						"/source/7/mute" : 0,
						"/source/7/hidewhenmute" : 0,
						"/source/7/aed" : [ 176.999038696289062, 0.97477400302887, 7.641583919525146 ],
						"/source/7/constraint/circular" : 0,
						"/source/7/coordinates/visible" : 1,
						"/source/7/orientation/mode" : "default",
						"/source/7/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/7/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/7/proportion" : 186.4949951171875,
						"/source/7/color" : [ 0.0, 1.0, 0.39215686917305, 1.0 ],
						"/source/7/image" : "",
						"/source/7/label" : "7",
						"/source/7/label/visible" : 1,
						"/source/7/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/7/label/justification" : "centred",
						"/source/7/vumeter/visible" : 1,
						"/source/7/vumeter/level" : -26.570999145507812,
						"/source/7/aperture" : 80.0,
						"/source/7/aperture/visible" : 0,
						"/source/7/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/7/radius" : 1.0,
						"/source/7/radius/visible" : 0,
						"/source/7/history/visible" : 0,
						"/source/7/history/size" : 100,
						"/source/7/history/color" : [ 0.0, 1.0, 0.39215686917305, 1.0 ],
						"/source/7/history/thickness" : 1.0,
						"/source/8/visible" : 1,
						"/source/8/editable" : 1,
						"/source/8/select" : 0,
						"/source/8/mute" : 0,
						"/source/8/hidewhenmute" : 0,
						"/source/8/aed" : [ 127.795173645019531, 0.682514309883118, 7.555520534515381 ],
						"/source/8/constraint/circular" : 0,
						"/source/8/coordinates/visible" : 1,
						"/source/8/orientation/mode" : "default",
						"/source/8/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/8/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/8/proportion" : 186.035018920898438,
						"/source/8/color" : [ 0.0, 1.0, 0.788235306739807, 1.0 ],
						"/source/8/image" : "",
						"/source/8/label" : "8",
						"/source/8/label/visible" : 1,
						"/source/8/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/8/label/justification" : "centred",
						"/source/8/vumeter/visible" : 1,
						"/source/8/vumeter/level" : -26.702999114990234,
						"/source/8/aperture" : 80.0,
						"/source/8/aperture/visible" : 0,
						"/source/8/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/8/radius" : 1.0,
						"/source/8/radius/visible" : 0,
						"/source/8/history/visible" : 0,
						"/source/8/history/size" : 100,
						"/source/8/history/color" : [ 0.0, 1.0, 0.788235306739807, 1.0 ],
						"/source/8/history/thickness" : 1.0,
						"/source/9/visible" : 1,
						"/source/9/editable" : 1,
						"/source/9/select" : 0,
						"/source/9/mute" : 0,
						"/source/9/hidewhenmute" : 0,
						"/source/9/aed" : [ -44.650341033935547, 1.059514164924622, 8.112052917480469 ],
						"/source/9/constraint/circular" : 0,
						"/source/9/coordinates/visible" : 1,
						"/source/9/orientation/mode" : "default",
						"/source/9/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/9/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/9/proportion" : 186.7249755859375,
						"/source/9/color" : [ 0.0, 0.811764717102051, 1.0, 1.0 ],
						"/source/9/image" : "",
						"/source/9/label" : "9",
						"/source/9/label/visible" : 1,
						"/source/9/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/9/label/justification" : "centred",
						"/source/9/vumeter/visible" : 1,
						"/source/9/vumeter/level" : -26.505001068115234,
						"/source/9/aperture" : 80.0,
						"/source/9/aperture/visible" : 0,
						"/source/9/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/9/radius" : 1.0,
						"/source/9/radius/visible" : 0,
						"/source/9/history/visible" : 0,
						"/source/9/history/size" : 100,
						"/source/9/history/color" : [ 0.0, 0.811764717102051, 1.0, 1.0 ],
						"/source/9/history/thickness" : 1.0,
						"/source/10/visible" : 1,
						"/source/10/editable" : 1,
						"/source/10/select" : 0,
						"/source/10/mute" : 0,
						"/source/10/hidewhenmute" : 0,
						"/source/10/aed" : [ -73.634544372558594, 11.232753753662109, 8.213756561279297 ],
						"/source/10/constraint/circular" : 0,
						"/source/10/coordinates/visible" : 1,
						"/source/10/orientation/mode" : "default",
						"/source/10/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/10/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/10/proportion" : 203.399993896484375,
						"/source/10/color" : [ 0.0, 0.415686279535294, 1.0, 1.0 ],
						"/source/10/image" : "",
						"/source/10/label" : "10",
						"/source/10/label/visible" : 1,
						"/source/10/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/10/label/justification" : "centred",
						"/source/10/vumeter/visible" : 1,
						"/source/10/vumeter/level" : -21.720001220703125,
						"/source/10/aperture" : 80.0,
						"/source/10/aperture/visible" : 0,
						"/source/10/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/10/radius" : 1.0,
						"/source/10/radius/visible" : 0,
						"/source/10/history/visible" : 0,
						"/source/10/history/size" : 100,
						"/source/10/history/color" : [ 0.0, 0.415686279535294, 1.0, 1.0 ],
						"/source/10/history/thickness" : 1.0,
						"/source/11/visible" : 1,
						"/source/11/editable" : 1,
						"/source/11/select" : 0,
						"/source/11/mute" : 0,
						"/source/11/hidewhenmute" : 0,
						"/source/11/aed" : [ -90.393341064453125, 0.0, 4.370103359222412 ],
						"/source/11/constraint/circular" : 0,
						"/source/11/coordinates/visible" : 1,
						"/source/11/orientation/mode" : "default",
						"/source/11/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/11/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/11/proportion" : 185.0,
						"/source/11/color" : [ 0.0, 0.015686275437474, 1.0, 1.0 ],
						"/source/11/image" : "",
						"/source/11/label" : "11",
						"/source/11/label/visible" : 1,
						"/source/11/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/11/label/justification" : "centred",
						"/source/11/vumeter/visible" : 1,
						"/source/11/vumeter/level" : -27.0,
						"/source/11/aperture" : 80.0,
						"/source/11/aperture/visible" : 0,
						"/source/11/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/11/radius" : 1.0,
						"/source/11/radius/visible" : 0,
						"/source/11/history/visible" : 0,
						"/source/11/history/size" : 100,
						"/source/11/history/color" : [ 0.0, 0.015686275437474, 1.0, 1.0 ],
						"/source/11/history/thickness" : 1.0,
						"/source/12/visible" : 1,
						"/source/12/editable" : 1,
						"/source/12/select" : 0,
						"/source/12/mute" : 0,
						"/source/12/hidewhenmute" : 0,
						"/source/12/aed" : [ -26.337690353393555, 0.0, 3.380961179733276 ],
						"/source/12/constraint/circular" : 0,
						"/source/12/coordinates/visible" : 1,
						"/source/12/orientation/mode" : "default",
						"/source/12/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/12/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/12/proportion" : 185.0,
						"/source/12/color" : [ 0.384313732385635, 0.0, 1.0, 1.0 ],
						"/source/12/image" : "",
						"/source/12/label" : "12",
						"/source/12/label/visible" : 1,
						"/source/12/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/12/label/justification" : "centred",
						"/source/12/vumeter/visible" : 1,
						"/source/12/vumeter/level" : -27.0,
						"/source/12/aperture" : 80.0,
						"/source/12/aperture/visible" : 0,
						"/source/12/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/12/radius" : 1.0,
						"/source/12/radius/visible" : 0,
						"/source/12/history/visible" : 0,
						"/source/12/history/size" : 100,
						"/source/12/history/color" : [ 0.384313732385635, 0.0, 1.0, 1.0 ],
						"/source/12/history/thickness" : 1.0,
						"/source/13/visible" : 1,
						"/source/13/editable" : 1,
						"/source/13/select" : 0,
						"/source/13/mute" : 0,
						"/source/13/hidewhenmute" : 0,
						"/source/13/aed" : [ 41.591426849365234, 0.0, 6.779004096984863 ],
						"/source/13/constraint/circular" : 0,
						"/source/13/coordinates/visible" : 1,
						"/source/13/orientation/mode" : "default",
						"/source/13/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/13/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/13/proportion" : 185.0,
						"/source/13/color" : [ 0.780392169952393, 0.0, 1.0, 1.0 ],
						"/source/13/image" : "",
						"/source/13/label" : "13",
						"/source/13/label/visible" : 1,
						"/source/13/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/13/label/justification" : "centred",
						"/source/13/vumeter/visible" : 1,
						"/source/13/vumeter/level" : -27.0,
						"/source/13/aperture" : 80.0,
						"/source/13/aperture/visible" : 0,
						"/source/13/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/13/radius" : 1.0,
						"/source/13/radius/visible" : 0,
						"/source/13/history/visible" : 0,
						"/source/13/history/size" : 100,
						"/source/13/history/color" : [ 0.780392169952393, 0.0, 1.0, 1.0 ],
						"/source/13/history/thickness" : 1.0,
						"/source/14/visible" : 1,
						"/source/14/editable" : 1,
						"/source/14/select" : 0,
						"/source/14/mute" : 0,
						"/source/14/hidewhenmute" : 0,
						"/source/14/aed" : [ 71.800834655761719, 0.0, 7.684399127960205 ],
						"/source/14/constraint/circular" : 0,
						"/source/14/coordinates/visible" : 1,
						"/source/14/orientation/mode" : "default",
						"/source/14/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/14/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/14/proportion" : 185.0,
						"/source/14/color" : [ 1.0, 0.0, 0.819607853889465, 1.0 ],
						"/source/14/image" : "",
						"/source/14/label" : "14",
						"/source/14/label/visible" : 1,
						"/source/14/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/14/label/justification" : "centred",
						"/source/14/vumeter/visible" : 1,
						"/source/14/vumeter/level" : -27.0,
						"/source/14/aperture" : 80.0,
						"/source/14/aperture/visible" : 0,
						"/source/14/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/14/radius" : 1.0,
						"/source/14/radius/visible" : 0,
						"/source/14/history/visible" : 0,
						"/source/14/history/size" : 100,
						"/source/14/history/color" : [ 1.0, 0.0, 0.819607853889465, 1.0 ],
						"/source/14/history/thickness" : 1.0,
						"/source/15/visible" : 1,
						"/source/15/editable" : 1,
						"/source/15/select" : 0,
						"/source/15/mute" : 0,
						"/source/15/hidewhenmute" : 0,
						"/source/15/aed" : [ 40.314098358154297, 0.0, 4.327816009521484 ],
						"/source/15/constraint/circular" : 0,
						"/source/15/coordinates/visible" : 1,
						"/source/15/orientation/mode" : "default",
						"/source/15/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/15/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/15/proportion" : 185.0,
						"/source/15/color" : [ 1.0, 0.0, 0.423529416322708, 1.0 ],
						"/source/15/image" : "",
						"/source/15/label" : "15",
						"/source/15/label/visible" : 1,
						"/source/15/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/15/label/justification" : "centred",
						"/source/15/vumeter/visible" : 1,
						"/source/15/vumeter/level" : -27.0,
						"/source/15/aperture" : 80.0,
						"/source/15/aperture/visible" : 0,
						"/source/15/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/15/radius" : 1.0,
						"/source/15/radius/visible" : 0,
						"/source/15/history/visible" : 0,
						"/source/15/history/size" : 100,
						"/source/15/history/color" : [ 1.0, 0.0, 0.423529416322708, 1.0 ],
						"/source/15/history/thickness" : 1.0,
						"/source/16/visible" : 1,
						"/source/16/editable" : 1,
						"/source/16/select" : 0,
						"/source/16/mute" : 0,
						"/source/16/hidewhenmute" : 0,
						"/source/16/aed" : [ 24.102235794067383, 0.0, 4.162930965423584 ],
						"/source/16/constraint/circular" : 0,
						"/source/16/coordinates/visible" : 1,
						"/source/16/orientation/mode" : "default",
						"/source/16/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/16/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/16/proportion" : 185.0,
						"/source/16/color" : [ 1.0, 0.0, 0.023529412224889, 1.0 ],
						"/source/16/image" : "",
						"/source/16/label" : "16",
						"/source/16/label/visible" : 1,
						"/source/16/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/16/label/justification" : "centred",
						"/source/16/vumeter/visible" : 1,
						"/source/16/vumeter/level" : -27.0,
						"/source/16/aperture" : 80.0,
						"/source/16/aperture/visible" : 0,
						"/source/16/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/16/radius" : 1.0,
						"/source/16/radius/visible" : 0,
						"/source/16/history/visible" : 0,
						"/source/16/history/size" : 100,
						"/source/16/history/color" : [ 1.0, 0.0, 0.023529412224889, 1.0 ],
						"/source/16/history/thickness" : 1.0,
						"/source/17/visible" : 0,
						"/source/17/editable" : 1,
						"/source/17/select" : 0,
						"/source/17/mute" : 0,
						"/source/17/hidewhenmute" : 0,
						"/source/17/aed" : [ -145.631790161132812, 0.0, 8.201816558837891 ],
						"/source/17/constraint/circular" : 0,
						"/source/17/coordinates/visible" : 1,
						"/source/17/orientation/mode" : "default",
						"/source/17/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/17/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/17/proportion" : 185.0,
						"/source/17/color" : [ 0.0, 0.0, 0.513725519180298, 1.0 ],
						"/source/17/image" : "",
						"/source/17/label" : "17",
						"/source/17/label/visible" : 1,
						"/source/17/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/17/label/justification" : "centred",
						"/source/17/vumeter/visible" : 0,
						"/source/17/vumeter/level" : -27.0,
						"/source/17/aperture" : 80.0,
						"/source/17/aperture/visible" : 0,
						"/source/17/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/17/radius" : 1.0,
						"/source/17/radius/visible" : 0,
						"/source/17/history/visible" : 0,
						"/source/17/history/size" : 100,
						"/source/17/history/color" : [ 0.0, 0.0, 0.513725519180298, 1.0 ],
						"/source/17/history/thickness" : 1.0,
						"/source/18/visible" : 0,
						"/source/18/editable" : 1,
						"/source/18/select" : 0,
						"/source/18/mute" : 0,
						"/source/18/hidewhenmute" : 0,
						"/source/18/aed" : [ -114.142997741699219, 0.0, 7.090197563171387 ],
						"/source/18/constraint/circular" : 0,
						"/source/18/coordinates/visible" : 1,
						"/source/18/orientation/mode" : "default",
						"/source/18/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/18/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/18/proportion" : 185.0,
						"/source/18/color" : [ 0.0, 0.0, 0.780392169952393, 1.0 ],
						"/source/18/image" : "",
						"/source/18/label" : "18",
						"/source/18/label/visible" : 1,
						"/source/18/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/18/label/justification" : "centred",
						"/source/18/vumeter/visible" : 0,
						"/source/18/vumeter/level" : -27.0,
						"/source/18/aperture" : 80.0,
						"/source/18/aperture/visible" : 0,
						"/source/18/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/18/radius" : 1.0,
						"/source/18/radius/visible" : 0,
						"/source/18/history/visible" : 0,
						"/source/18/history/size" : 100,
						"/source/18/history/color" : [ 0.0, 0.0, 0.780392169952393, 1.0 ],
						"/source/18/history/thickness" : 1.0,
						"/source/19/visible" : 1,
						"/source/19/editable" : 1,
						"/source/19/select" : 0,
						"/source/19/mute" : 0,
						"/source/19/hidewhenmute" : 0,
						"/source/19/aed" : [ 17.729902267456055, 0.0, 5.910744667053223 ],
						"/source/19/constraint/circular" : 0,
						"/source/19/coordinates/visible" : 1,
						"/source/19/orientation/mode" : "default",
						"/source/19/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/19/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/19/proportion" : 185.0,
						"/source/19/color" : [ 0.0, 0.047058824449778, 1.0, 1.0 ],
						"/source/19/image" : "",
						"/source/19/label" : "19",
						"/source/19/label/visible" : 1,
						"/source/19/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/19/label/justification" : "centred",
						"/source/19/vumeter/visible" : 0,
						"/source/19/vumeter/level" : -27.0,
						"/source/19/aperture" : 80.0,
						"/source/19/aperture/visible" : 0,
						"/source/19/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/19/radius" : 1.0,
						"/source/19/radius/visible" : 0,
						"/source/19/history/visible" : 0,
						"/source/19/history/size" : 100,
						"/source/19/history/color" : [ 0.0, 0.047058824449778, 1.0, 1.0 ],
						"/source/19/history/thickness" : 1.0,
						"/source/20/visible" : 1,
						"/source/20/editable" : 1,
						"/source/20/select" : 0,
						"/source/20/mute" : 0,
						"/source/20/hidewhenmute" : 0,
						"/source/20/aed" : [ 72.064285278320312, 0.0, 6.169837474822998 ],
						"/source/20/constraint/circular" : 0,
						"/source/20/coordinates/visible" : 1,
						"/source/20/orientation/mode" : "default",
						"/source/20/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/20/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/20/proportion" : 185.0,
						"/source/20/color" : [ 0.0, 0.313725501298904, 1.0, 1.0 ],
						"/source/20/image" : "",
						"/source/20/label" : "20",
						"/source/20/label/visible" : 1,
						"/source/20/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/20/label/justification" : "centred",
						"/source/20/vumeter/visible" : 0,
						"/source/20/vumeter/level" : -27.0,
						"/source/20/aperture" : 80.0,
						"/source/20/aperture/visible" : 0,
						"/source/20/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/20/radius" : 1.0,
						"/source/20/radius/visible" : 0,
						"/source/20/history/visible" : 0,
						"/source/20/history/size" : 100,
						"/source/20/history/color" : [ 0.0, 0.313725501298904, 1.0, 1.0 ],
						"/source/20/history/thickness" : 1.0,
						"/source/21/visible" : 1,
						"/source/21/editable" : 1,
						"/source/21/select" : 0,
						"/source/21/mute" : 0,
						"/source/21/hidewhenmute" : 0,
						"/source/21/aed" : [ -44.902503967285156, 0.0, 12.466310501098633 ],
						"/source/21/constraint/circular" : 0,
						"/source/21/coordinates/visible" : 1,
						"/source/21/orientation/mode" : "default",
						"/source/21/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/21/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/21/proportion" : 185.0,
						"/source/21/color" : [ 0.0, 0.576470613479614, 1.0, 1.0 ],
						"/source/21/image" : "",
						"/source/21/label" : "21",
						"/source/21/label/visible" : 1,
						"/source/21/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/21/label/justification" : "centred",
						"/source/21/vumeter/visible" : 0,
						"/source/21/vumeter/level" : -27.0,
						"/source/21/aperture" : 80.0,
						"/source/21/aperture/visible" : 0,
						"/source/21/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/21/radius" : 1.0,
						"/source/21/radius/visible" : 0,
						"/source/21/history/visible" : 0,
						"/source/21/history/size" : 100,
						"/source/21/history/color" : [ 0.0, 0.576470613479614, 1.0, 1.0 ],
						"/source/21/history/thickness" : 1.0,
						"/source/22/visible" : 1,
						"/source/22/editable" : 1,
						"/source/22/select" : 0,
						"/source/22/mute" : 0,
						"/source/22/hidewhenmute" : 0,
						"/source/22/aed" : [ 45.741546630859375, 0.0, 12.566340446472168 ],
						"/source/22/constraint/circular" : 0,
						"/source/22/coordinates/visible" : 1,
						"/source/22/orientation/mode" : "default",
						"/source/22/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/22/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/22/proportion" : 185.0,
						"/source/22/color" : [ 0.0, 0.843137264251709, 1.0, 1.0 ],
						"/source/22/image" : "",
						"/source/22/label" : "22",
						"/source/22/label/visible" : 1,
						"/source/22/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/22/label/justification" : "centred",
						"/source/22/vumeter/visible" : 0,
						"/source/22/vumeter/level" : -27.0,
						"/source/22/aperture" : 80.0,
						"/source/22/aperture/visible" : 0,
						"/source/22/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/22/radius" : 1.0,
						"/source/22/radius/visible" : 0,
						"/source/22/history/visible" : 0,
						"/source/22/history/size" : 100,
						"/source/22/history/color" : [ 0.0, 0.843137264251709, 1.0, 1.0 ],
						"/source/22/history/thickness" : 1.0,
						"/source/23/visible" : 1,
						"/source/23/editable" : 1,
						"/source/23/select" : 0,
						"/source/23/mute" : 0,
						"/source/23/hidewhenmute" : 0,
						"/source/23/aed" : [ -177.854476928710938, 0.0, 3.472434520721436 ],
						"/source/23/constraint/circular" : 0,
						"/source/23/coordinates/visible" : 1,
						"/source/23/orientation/mode" : "default",
						"/source/23/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/23/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/23/proportion" : 185.0,
						"/source/23/color" : [ 0.109803922474384, 1.0, 0.890196084976196, 1.0 ],
						"/source/23/image" : "",
						"/source/23/label" : "23",
						"/source/23/label/visible" : 1,
						"/source/23/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/23/label/justification" : "centred",
						"/source/23/vumeter/visible" : 0,
						"/source/23/vumeter/level" : -27.0,
						"/source/23/aperture" : 80.0,
						"/source/23/aperture/visible" : 0,
						"/source/23/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/23/radius" : 1.0,
						"/source/23/radius/visible" : 0,
						"/source/23/history/visible" : 0,
						"/source/23/history/size" : 100,
						"/source/23/history/color" : [ 0.109803922474384, 1.0, 0.890196084976196, 1.0 ],
						"/source/23/history/thickness" : 1.0,
						"/source/24/visible" : 1,
						"/source/24/editable" : 1,
						"/source/24/select" : 0,
						"/source/24/mute" : 0,
						"/source/24/hidewhenmute" : 0,
						"/source/24/aed" : [ -135.229583740234375, 0.0, 12.353255271911621 ],
						"/source/24/constraint/circular" : 0,
						"/source/24/coordinates/visible" : 1,
						"/source/24/orientation/mode" : "default",
						"/source/24/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/24/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/24/proportion" : 185.0,
						"/source/24/color" : [ 0.376470595598221, 1.0, 0.623529434204102, 1.0 ],
						"/source/24/image" : "",
						"/source/24/label" : "24",
						"/source/24/label/visible" : 1,
						"/source/24/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/24/label/justification" : "centred",
						"/source/24/vumeter/visible" : 0,
						"/source/24/vumeter/level" : -27.0,
						"/source/24/aperture" : 80.0,
						"/source/24/aperture/visible" : 0,
						"/source/24/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/24/radius" : 1.0,
						"/source/24/radius/visible" : 0,
						"/source/24/history/visible" : 0,
						"/source/24/history/size" : 100,
						"/source/24/history/color" : [ 0.376470595598221, 1.0, 0.623529434204102, 1.0 ],
						"/source/24/history/thickness" : 1.0,
						"/source/25/visible" : 1,
						"/source/25/editable" : 1,
						"/source/25/select" : 0,
						"/source/25/mute" : 0,
						"/source/25/hidewhenmute" : 0,
						"/source/25/aed" : [ 135.0, 0.0, 12.544073104858398 ],
						"/source/25/constraint/circular" : 0,
						"/source/25/coordinates/visible" : 1,
						"/source/25/orientation/mode" : "default",
						"/source/25/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/25/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/25/proportion" : 185.0,
						"/source/25/color" : [ 0.639215707778931, 1.0, 0.360784322023392, 1.0 ],
						"/source/25/image" : "",
						"/source/25/label" : "25",
						"/source/25/label/visible" : 1,
						"/source/25/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/25/label/justification" : "centred",
						"/source/25/vumeter/visible" : 0,
						"/source/25/vumeter/level" : -27.0,
						"/source/25/aperture" : 80.0,
						"/source/25/aperture/visible" : 0,
						"/source/25/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/25/radius" : 1.0,
						"/source/25/radius/visible" : 0,
						"/source/25/history/visible" : 0,
						"/source/25/history/size" : 100,
						"/source/25/history/color" : [ 0.639215707778931, 1.0, 0.360784322023392, 1.0 ],
						"/source/25/history/thickness" : 1.0,
						"/source/26/visible" : 1,
						"/source/26/editable" : 1,
						"/source/26/select" : 0,
						"/source/26/mute" : 0,
						"/source/26/hidewhenmute" : 0,
						"/source/26/aed" : [ -52.115947723388672, 0.0, 5.536867618560791 ],
						"/source/26/constraint/circular" : 0,
						"/source/26/coordinates/visible" : 1,
						"/source/26/orientation/mode" : "default",
						"/source/26/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/26/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/26/proportion" : 185.0,
						"/source/26/color" : [ 0.905882358551025, 1.0, 0.094117648899555, 1.0 ],
						"/source/26/image" : "",
						"/source/26/label" : "26",
						"/source/26/label/visible" : 1,
						"/source/26/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/26/label/justification" : "centred",
						"/source/26/vumeter/visible" : 0,
						"/source/26/vumeter/level" : -27.0,
						"/source/26/aperture" : 80.0,
						"/source/26/aperture/visible" : 0,
						"/source/26/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/26/radius" : 1.0,
						"/source/26/radius/visible" : 0,
						"/source/26/history/visible" : 0,
						"/source/26/history/size" : 100,
						"/source/26/history/color" : [ 0.905882358551025, 1.0, 0.094117648899555, 1.0 ],
						"/source/26/history/thickness" : 1.0,
						"/source/27/visible" : 1,
						"/source/27/editable" : 1,
						"/source/27/select" : 0,
						"/source/27/mute" : 0,
						"/source/27/hidewhenmute" : 0,
						"/source/27/aed" : [ 49.085620880126953, 0.0, 5.954829692840576 ],
						"/source/27/constraint/circular" : 0,
						"/source/27/coordinates/visible" : 1,
						"/source/27/orientation/mode" : "default",
						"/source/27/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/27/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/27/proportion" : 185.0,
						"/source/27/color" : [ 1.0, 0.82745099067688, 0.0, 1.0 ],
						"/source/27/image" : "",
						"/source/27/label" : "27",
						"/source/27/label/visible" : 1,
						"/source/27/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/27/label/justification" : "centred",
						"/source/27/vumeter/visible" : 0,
						"/source/27/vumeter/level" : -27.0,
						"/source/27/aperture" : 80.0,
						"/source/27/aperture/visible" : 0,
						"/source/27/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/27/radius" : 1.0,
						"/source/27/radius/visible" : 0,
						"/source/27/history/visible" : 0,
						"/source/27/history/size" : 100,
						"/source/27/history/color" : [ 1.0, 0.82745099067688, 0.0, 1.0 ],
						"/source/27/history/thickness" : 1.0,
						"/source/28/visible" : 1,
						"/source/28/editable" : 1,
						"/source/28/select" : 0,
						"/source/28/mute" : 0,
						"/source/28/hidewhenmute" : 0,
						"/source/28/aed" : [ -4.906062602996826, 0.0, 2.338567733764648 ],
						"/source/28/constraint/circular" : 0,
						"/source/28/coordinates/visible" : 1,
						"/source/28/orientation/mode" : "default",
						"/source/28/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/28/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/28/proportion" : 185.0,
						"/source/28/color" : [ 1.0, 0.560784339904785, 0.0, 1.0 ],
						"/source/28/image" : "",
						"/source/28/label" : "28",
						"/source/28/label/visible" : 1,
						"/source/28/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/28/label/justification" : "centred",
						"/source/28/vumeter/visible" : 0,
						"/source/28/vumeter/level" : -27.0,
						"/source/28/aperture" : 80.0,
						"/source/28/aperture/visible" : 0,
						"/source/28/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/28/radius" : 1.0,
						"/source/28/radius/visible" : 0,
						"/source/28/history/visible" : 0,
						"/source/28/history/size" : 100,
						"/source/28/history/color" : [ 1.0, 0.560784339904785, 0.0, 1.0 ],
						"/source/28/history/thickness" : 1.0,
						"/source/29/visible" : 1,
						"/source/29/editable" : 1,
						"/source/29/select" : 0,
						"/source/29/mute" : 0,
						"/source/29/hidewhenmute" : 0,
						"/source/29/aed" : [ -145.6502685546875, 0.0, 6.50429105758667 ],
						"/source/29/constraint/circular" : 0,
						"/source/29/coordinates/visible" : 1,
						"/source/29/orientation/mode" : "default",
						"/source/29/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/29/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/29/proportion" : 185.0,
						"/source/29/color" : [ 1.0, 0.298039227724075, 0.0, 1.0 ],
						"/source/29/image" : "",
						"/source/29/label" : "29",
						"/source/29/label/visible" : 1,
						"/source/29/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/29/label/justification" : "centred",
						"/source/29/vumeter/visible" : 0,
						"/source/29/vumeter/level" : -27.0,
						"/source/29/aperture" : 80.0,
						"/source/29/aperture/visible" : 0,
						"/source/29/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/29/radius" : 1.0,
						"/source/29/radius/visible" : 0,
						"/source/29/history/visible" : 0,
						"/source/29/history/size" : 100,
						"/source/29/history/color" : [ 1.0, 0.298039227724075, 0.0, 1.0 ],
						"/source/29/history/thickness" : 1.0,
						"/source/30/visible" : 1,
						"/source/30/editable" : 1,
						"/source/30/select" : 0,
						"/source/30/mute" : 0,
						"/source/30/hidewhenmute" : 0,
						"/source/30/aed" : [ 133.726974487304688, 0.0, 6.365531921386719 ],
						"/source/30/constraint/circular" : 0,
						"/source/30/coordinates/visible" : 1,
						"/source/30/orientation/mode" : "default",
						"/source/30/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/30/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/30/proportion" : 185.0,
						"/source/30/color" : [ 1.0, 0.031372550874949, 0.0, 1.0 ],
						"/source/30/image" : "",
						"/source/30/label" : "30",
						"/source/30/label/visible" : 1,
						"/source/30/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/30/label/justification" : "centred",
						"/source/30/vumeter/visible" : 0,
						"/source/30/vumeter/level" : -27.0,
						"/source/30/aperture" : 80.0,
						"/source/30/aperture/visible" : 0,
						"/source/30/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/30/radius" : 1.0,
						"/source/30/radius/visible" : 0,
						"/source/30/history/visible" : 0,
						"/source/30/history/size" : 100,
						"/source/30/history/color" : [ 1.0, 0.031372550874949, 0.0, 1.0 ],
						"/source/30/history/thickness" : 1.0,
						"/source/31/visible" : 1,
						"/source/31/editable" : 1,
						"/source/31/select" : 0,
						"/source/31/mute" : 0,
						"/source/31/hidewhenmute" : 0,
						"/source/31/aed" : [ 45.129478454589844, 0.0, 12.51582145690918 ],
						"/source/31/constraint/circular" : 0,
						"/source/31/coordinates/visible" : 1,
						"/source/31/orientation/mode" : "default",
						"/source/31/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/31/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/31/proportion" : 185.0,
						"/source/31/color" : [ 0.764705896377563, 0.0, 0.0, 1.0 ],
						"/source/31/image" : "",
						"/source/31/label" : "31",
						"/source/31/label/visible" : 1,
						"/source/31/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/31/label/justification" : "centred",
						"/source/31/vumeter/visible" : 0,
						"/source/31/vumeter/level" : -27.0,
						"/source/31/aperture" : 80.0,
						"/source/31/aperture/visible" : 0,
						"/source/31/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/31/radius" : 1.0,
						"/source/31/radius/visible" : 0,
						"/source/31/history/visible" : 0,
						"/source/31/history/size" : 100,
						"/source/31/history/color" : [ 0.764705896377563, 0.0, 0.0, 1.0 ],
						"/source/31/history/thickness" : 1.0,
						"/source/32/visible" : 1,
						"/source/32/editable" : 1,
						"/source/32/select" : 0,
						"/source/32/mute" : 0,
						"/source/32/hidewhenmute" : 0,
						"/source/32/aed" : [ -136.316909790039062, 0.0, 12.30690860748291 ],
						"/source/32/constraint/circular" : 0,
						"/source/32/coordinates/visible" : 1,
						"/source/32/orientation/mode" : "default",
						"/source/32/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/32/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/source/32/proportion" : 185.0,
						"/source/32/color" : [ 0.501960813999176, 0.0, 0.0, 1.0 ],
						"/source/32/image" : "",
						"/source/32/label" : "31",
						"/source/32/label/visible" : 1,
						"/source/32/label/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/source/32/label/justification" : "centred",
						"/source/32/vumeter/visible" : 0,
						"/source/32/vumeter/level" : -27.0,
						"/source/32/aperture" : 80.0,
						"/source/32/aperture/visible" : 0,
						"/source/32/aperture/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/source/32/radius" : 1.0,
						"/source/32/radius/visible" : 0,
						"/source/32/history/visible" : 0,
						"/source/32/history/size" : 100,
						"/source/32/history/color" : [ 0.501960813999176, 0.0, 0.0, 1.0 ],
						"/source/32/history/thickness" : 1.0,
						"/speaker/number" : 34,
						"/speakers/aed" : [ -70.759315490722656, 0.0, 6.408989429473877, -64.317207336425781, 0.0, 5.983085632324219, -57.266624450683594, 0.0, 5.581339359283447, -49.529899597167969, 0.0, 5.210683345794678, -41.022560119628906, 0.0, 4.88301944732666, -31.724756240844727, 0.0, 4.609774112701416, -21.663639068603516, 0.0, 4.401920795440674, -11.010123252868652, 0.0, 4.272644519805908, 0.0, 0.0, 4.228000164031982, 11.010123252868652, 0.0, 4.272644519805908, 21.675735473632812, 0.0, 4.402289867401123, 31.724756240844727, 0.0, 4.609774112701416, 41.031414031982422, 0.0, 4.883676052093506, 49.529899597167969, 0.0, 5.210683345794678, 57.275260925292969, 0.0, 5.580798625946045, 64.317207336425781, 0.0, 5.983085632324219, 70.810348510742188, 0.0, 6.410176753997803, 109.240684509277344, 0.0, 6.408989429473877, 115.682792663574219, 0.0, 5.983085632324219, 122.733375549316406, 0.0, 5.581339359283447, 130.470108032226562, 0.0, 5.210683345794678, 138.977447509765625, 0.0, 4.88301944732666, 148.275238037109375, 0.0, 4.609774112701416, 158.33636474609375, 0.0, 4.401920795440674, 168.989883422851562, 0.0, 4.272644519805908, -180.0, 0.0, 4.228000164031982, -168.989883422851562, 0.0, 4.272644519805908, -158.324264526367188, 0.0, 4.402289867401123, -148.275238037109375, 0.0, 4.609774112701416, -138.968582153320312, 0.0, 4.883676052093506, -130.470108032226562, 0.0, 5.210683345794678, -122.724739074707031, 0.0, 5.580798625946045, -115.682792663574219, 0.0, 5.983085632324219, -109.189651489257812, 0.0, 6.410176753997803 ],
						"/speaker/1/visible" : 0,
						"/speaker/1/editable" : 0,
						"/speaker/1/select" : 0,
						"/speaker/1/aed" : [ -70.759315490722656, 0.0, 6.408989429473877 ],
						"/speaker/1/constraint/circular" : 0,
						"/speaker/1/coordinates/visible" : 1,
						"/speaker/1/proportion" : 100.0,
						"/speaker/1/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/1/image" : "",
						"/speaker/1/label" : "1",
						"/speaker/1/label/visible" : 1,
						"/speaker/1/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/1/label/justification" : "centred",
						"/speaker/1/vumeter/visible" : 0,
						"/speaker/1/vumeter/level" : -60.0,
						"/speaker/2/visible" : 0,
						"/speaker/2/editable" : 0,
						"/speaker/2/select" : 0,
						"/speaker/2/aed" : [ -64.317207336425781, 0.0, 5.983085632324219 ],
						"/speaker/2/constraint/circular" : 0,
						"/speaker/2/coordinates/visible" : 1,
						"/speaker/2/proportion" : 100.0,
						"/speaker/2/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/2/image" : "",
						"/speaker/2/label" : "2",
						"/speaker/2/label/visible" : 1,
						"/speaker/2/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/2/label/justification" : "centred",
						"/speaker/2/vumeter/visible" : 0,
						"/speaker/2/vumeter/level" : -60.0,
						"/speaker/3/visible" : 0,
						"/speaker/3/editable" : 0,
						"/speaker/3/select" : 0,
						"/speaker/3/aed" : [ -57.266624450683594, 0.0, 5.581339359283447 ],
						"/speaker/3/constraint/circular" : 0,
						"/speaker/3/coordinates/visible" : 1,
						"/speaker/3/proportion" : 100.0,
						"/speaker/3/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/3/image" : "",
						"/speaker/3/label" : "3",
						"/speaker/3/label/visible" : 1,
						"/speaker/3/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/3/label/justification" : "centred",
						"/speaker/3/vumeter/visible" : 0,
						"/speaker/3/vumeter/level" : -60.0,
						"/speaker/4/visible" : 0,
						"/speaker/4/editable" : 0,
						"/speaker/4/select" : 0,
						"/speaker/4/aed" : [ -49.529899597167969, 0.0, 5.210683345794678 ],
						"/speaker/4/constraint/circular" : 0,
						"/speaker/4/coordinates/visible" : 1,
						"/speaker/4/proportion" : 100.0,
						"/speaker/4/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/4/image" : "",
						"/speaker/4/label" : "4",
						"/speaker/4/label/visible" : 1,
						"/speaker/4/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/4/label/justification" : "centred",
						"/speaker/4/vumeter/visible" : 0,
						"/speaker/4/vumeter/level" : -60.0,
						"/speaker/5/visible" : 0,
						"/speaker/5/editable" : 0,
						"/speaker/5/select" : 0,
						"/speaker/5/aed" : [ -41.022560119628906, 0.0, 4.88301944732666 ],
						"/speaker/5/constraint/circular" : 0,
						"/speaker/5/coordinates/visible" : 1,
						"/speaker/5/proportion" : 100.0,
						"/speaker/5/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/5/image" : "",
						"/speaker/5/label" : "5",
						"/speaker/5/label/visible" : 1,
						"/speaker/5/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/5/label/justification" : "centred",
						"/speaker/5/vumeter/visible" : 0,
						"/speaker/5/vumeter/level" : -60.0,
						"/speaker/6/visible" : 0,
						"/speaker/6/editable" : 0,
						"/speaker/6/select" : 0,
						"/speaker/6/aed" : [ -31.724756240844727, 0.0, 4.609774112701416 ],
						"/speaker/6/constraint/circular" : 0,
						"/speaker/6/coordinates/visible" : 1,
						"/speaker/6/proportion" : 100.0,
						"/speaker/6/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/6/image" : "",
						"/speaker/6/label" : "6",
						"/speaker/6/label/visible" : 1,
						"/speaker/6/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/6/label/justification" : "centred",
						"/speaker/6/vumeter/visible" : 0,
						"/speaker/6/vumeter/level" : -60.0,
						"/speaker/7/visible" : 0,
						"/speaker/7/editable" : 0,
						"/speaker/7/select" : 0,
						"/speaker/7/aed" : [ -21.663639068603516, 0.0, 4.401920795440674 ],
						"/speaker/7/constraint/circular" : 0,
						"/speaker/7/coordinates/visible" : 1,
						"/speaker/7/proportion" : 100.0,
						"/speaker/7/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/7/image" : "",
						"/speaker/7/label" : "7",
						"/speaker/7/label/visible" : 1,
						"/speaker/7/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/7/label/justification" : "centred",
						"/speaker/7/vumeter/visible" : 0,
						"/speaker/7/vumeter/level" : -60.0,
						"/speaker/8/visible" : 0,
						"/speaker/8/editable" : 0,
						"/speaker/8/select" : 0,
						"/speaker/8/aed" : [ -11.010123252868652, 0.0, 4.272644519805908 ],
						"/speaker/8/constraint/circular" : 0,
						"/speaker/8/coordinates/visible" : 1,
						"/speaker/8/proportion" : 100.0,
						"/speaker/8/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/8/image" : "",
						"/speaker/8/label" : "8",
						"/speaker/8/label/visible" : 1,
						"/speaker/8/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/8/label/justification" : "centred",
						"/speaker/8/vumeter/visible" : 0,
						"/speaker/8/vumeter/level" : -60.0,
						"/speaker/9/visible" : 0,
						"/speaker/9/editable" : 0,
						"/speaker/9/select" : 0,
						"/speaker/9/aed" : [ 0.0, 0.0, 4.228000164031982 ],
						"/speaker/9/constraint/circular" : 0,
						"/speaker/9/coordinates/visible" : 1,
						"/speaker/9/proportion" : 100.0,
						"/speaker/9/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/9/image" : "",
						"/speaker/9/label" : "9",
						"/speaker/9/label/visible" : 1,
						"/speaker/9/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/9/label/justification" : "centred",
						"/speaker/9/vumeter/visible" : 0,
						"/speaker/9/vumeter/level" : -60.0,
						"/speaker/10/visible" : 0,
						"/speaker/10/editable" : 0,
						"/speaker/10/select" : 0,
						"/speaker/10/aed" : [ 11.010123252868652, 0.0, 4.272644519805908 ],
						"/speaker/10/constraint/circular" : 0,
						"/speaker/10/coordinates/visible" : 1,
						"/speaker/10/proportion" : 100.0,
						"/speaker/10/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/10/image" : "",
						"/speaker/10/label" : "10",
						"/speaker/10/label/visible" : 1,
						"/speaker/10/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/10/label/justification" : "centred",
						"/speaker/10/vumeter/visible" : 0,
						"/speaker/10/vumeter/level" : -60.0,
						"/speaker/11/visible" : 0,
						"/speaker/11/editable" : 0,
						"/speaker/11/select" : 0,
						"/speaker/11/aed" : [ 21.675735473632812, 0.0, 4.402289867401123 ],
						"/speaker/11/constraint/circular" : 0,
						"/speaker/11/coordinates/visible" : 1,
						"/speaker/11/proportion" : 100.0,
						"/speaker/11/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/11/image" : "",
						"/speaker/11/label" : "11",
						"/speaker/11/label/visible" : 1,
						"/speaker/11/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/11/label/justification" : "centred",
						"/speaker/11/vumeter/visible" : 0,
						"/speaker/11/vumeter/level" : -60.0,
						"/speaker/12/visible" : 0,
						"/speaker/12/editable" : 0,
						"/speaker/12/select" : 0,
						"/speaker/12/aed" : [ 31.724756240844727, 0.0, 4.609774112701416 ],
						"/speaker/12/constraint/circular" : 0,
						"/speaker/12/coordinates/visible" : 1,
						"/speaker/12/proportion" : 100.0,
						"/speaker/12/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/12/image" : "",
						"/speaker/12/label" : "12",
						"/speaker/12/label/visible" : 1,
						"/speaker/12/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/12/label/justification" : "centred",
						"/speaker/12/vumeter/visible" : 0,
						"/speaker/12/vumeter/level" : -60.0,
						"/speaker/13/visible" : 0,
						"/speaker/13/editable" : 0,
						"/speaker/13/select" : 0,
						"/speaker/13/aed" : [ 41.031414031982422, 0.0, 4.883676052093506 ],
						"/speaker/13/constraint/circular" : 0,
						"/speaker/13/coordinates/visible" : 1,
						"/speaker/13/proportion" : 100.0,
						"/speaker/13/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/13/image" : "",
						"/speaker/13/label" : "13",
						"/speaker/13/label/visible" : 1,
						"/speaker/13/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/13/label/justification" : "centred",
						"/speaker/13/vumeter/visible" : 0,
						"/speaker/13/vumeter/level" : -60.0,
						"/speaker/14/visible" : 0,
						"/speaker/14/editable" : 0,
						"/speaker/14/select" : 0,
						"/speaker/14/aed" : [ 49.529899597167969, 0.0, 5.210683345794678 ],
						"/speaker/14/constraint/circular" : 0,
						"/speaker/14/coordinates/visible" : 1,
						"/speaker/14/proportion" : 100.0,
						"/speaker/14/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/14/image" : "",
						"/speaker/14/label" : "14",
						"/speaker/14/label/visible" : 1,
						"/speaker/14/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/14/label/justification" : "centred",
						"/speaker/14/vumeter/visible" : 0,
						"/speaker/14/vumeter/level" : -60.0,
						"/speaker/15/visible" : 0,
						"/speaker/15/editable" : 0,
						"/speaker/15/select" : 0,
						"/speaker/15/aed" : [ 57.275260925292969, 0.0, 5.580798625946045 ],
						"/speaker/15/constraint/circular" : 0,
						"/speaker/15/coordinates/visible" : 1,
						"/speaker/15/proportion" : 100.0,
						"/speaker/15/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/15/image" : "",
						"/speaker/15/label" : "15",
						"/speaker/15/label/visible" : 1,
						"/speaker/15/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/15/label/justification" : "centred",
						"/speaker/15/vumeter/visible" : 0,
						"/speaker/15/vumeter/level" : -60.0,
						"/speaker/16/visible" : 0,
						"/speaker/16/editable" : 0,
						"/speaker/16/select" : 0,
						"/speaker/16/aed" : [ 64.317207336425781, 0.0, 5.983085632324219 ],
						"/speaker/16/constraint/circular" : 0,
						"/speaker/16/coordinates/visible" : 1,
						"/speaker/16/proportion" : 100.0,
						"/speaker/16/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/16/image" : "",
						"/speaker/16/label" : "16",
						"/speaker/16/label/visible" : 1,
						"/speaker/16/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/16/label/justification" : "centred",
						"/speaker/16/vumeter/visible" : 0,
						"/speaker/16/vumeter/level" : -60.0,
						"/speaker/17/visible" : 0,
						"/speaker/17/editable" : 0,
						"/speaker/17/select" : 0,
						"/speaker/17/aed" : [ 70.810348510742188, 0.0, 6.410176753997803 ],
						"/speaker/17/constraint/circular" : 0,
						"/speaker/17/coordinates/visible" : 1,
						"/speaker/17/proportion" : 100.0,
						"/speaker/17/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/17/image" : "",
						"/speaker/17/label" : "17",
						"/speaker/17/label/visible" : 1,
						"/speaker/17/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/17/label/justification" : "centred",
						"/speaker/17/vumeter/visible" : 0,
						"/speaker/17/vumeter/level" : -60.0,
						"/speaker/18/visible" : 0,
						"/speaker/18/editable" : 0,
						"/speaker/18/select" : 0,
						"/speaker/18/aed" : [ 109.240684509277344, 0.0, 6.408989429473877 ],
						"/speaker/18/constraint/circular" : 0,
						"/speaker/18/coordinates/visible" : 1,
						"/speaker/18/proportion" : 100.0,
						"/speaker/18/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/18/image" : "",
						"/speaker/18/label" : "18",
						"/speaker/18/label/visible" : 1,
						"/speaker/18/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/18/label/justification" : "centred",
						"/speaker/18/vumeter/visible" : 0,
						"/speaker/18/vumeter/level" : -60.0,
						"/speaker/19/visible" : 0,
						"/speaker/19/editable" : 0,
						"/speaker/19/select" : 0,
						"/speaker/19/aed" : [ 115.682792663574219, 0.0, 5.983085632324219 ],
						"/speaker/19/constraint/circular" : 0,
						"/speaker/19/coordinates/visible" : 1,
						"/speaker/19/proportion" : 100.0,
						"/speaker/19/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/19/image" : "",
						"/speaker/19/label" : "19",
						"/speaker/19/label/visible" : 1,
						"/speaker/19/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/19/label/justification" : "centred",
						"/speaker/19/vumeter/visible" : 0,
						"/speaker/19/vumeter/level" : -60.0,
						"/speaker/20/visible" : 0,
						"/speaker/20/editable" : 0,
						"/speaker/20/select" : 0,
						"/speaker/20/aed" : [ 122.733375549316406, 0.0, 5.581339359283447 ],
						"/speaker/20/constraint/circular" : 0,
						"/speaker/20/coordinates/visible" : 1,
						"/speaker/20/proportion" : 100.0,
						"/speaker/20/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/20/image" : "",
						"/speaker/20/label" : "20",
						"/speaker/20/label/visible" : 1,
						"/speaker/20/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/20/label/justification" : "centred",
						"/speaker/20/vumeter/visible" : 0,
						"/speaker/20/vumeter/level" : -60.0,
						"/speaker/21/visible" : 0,
						"/speaker/21/editable" : 0,
						"/speaker/21/select" : 0,
						"/speaker/21/aed" : [ 130.470108032226562, 0.0, 5.210683345794678 ],
						"/speaker/21/constraint/circular" : 0,
						"/speaker/21/coordinates/visible" : 1,
						"/speaker/21/proportion" : 100.0,
						"/speaker/21/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/21/image" : "",
						"/speaker/21/label" : "21",
						"/speaker/21/label/visible" : 1,
						"/speaker/21/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/21/label/justification" : "centred",
						"/speaker/21/vumeter/visible" : 0,
						"/speaker/21/vumeter/level" : -60.0,
						"/speaker/22/visible" : 0,
						"/speaker/22/editable" : 0,
						"/speaker/22/select" : 0,
						"/speaker/22/aed" : [ 138.977447509765625, 0.0, 4.88301944732666 ],
						"/speaker/22/constraint/circular" : 0,
						"/speaker/22/coordinates/visible" : 1,
						"/speaker/22/proportion" : 100.0,
						"/speaker/22/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/22/image" : "",
						"/speaker/22/label" : "22",
						"/speaker/22/label/visible" : 1,
						"/speaker/22/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/22/label/justification" : "centred",
						"/speaker/22/vumeter/visible" : 0,
						"/speaker/22/vumeter/level" : -60.0,
						"/speaker/23/visible" : 0,
						"/speaker/23/editable" : 0,
						"/speaker/23/select" : 0,
						"/speaker/23/aed" : [ 148.275238037109375, 0.0, 4.609774112701416 ],
						"/speaker/23/constraint/circular" : 0,
						"/speaker/23/coordinates/visible" : 1,
						"/speaker/23/proportion" : 100.0,
						"/speaker/23/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/23/image" : "",
						"/speaker/23/label" : "23",
						"/speaker/23/label/visible" : 1,
						"/speaker/23/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/23/label/justification" : "centred",
						"/speaker/23/vumeter/visible" : 0,
						"/speaker/23/vumeter/level" : -60.0,
						"/speaker/24/visible" : 0,
						"/speaker/24/editable" : 0,
						"/speaker/24/select" : 0,
						"/speaker/24/aed" : [ 158.33636474609375, 0.0, 4.401920795440674 ],
						"/speaker/24/constraint/circular" : 0,
						"/speaker/24/coordinates/visible" : 1,
						"/speaker/24/proportion" : 100.0,
						"/speaker/24/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/24/image" : "",
						"/speaker/24/label" : "24",
						"/speaker/24/label/visible" : 1,
						"/speaker/24/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/24/label/justification" : "centred",
						"/speaker/24/vumeter/visible" : 0,
						"/speaker/24/vumeter/level" : -60.0,
						"/speaker/25/visible" : 0,
						"/speaker/25/editable" : 0,
						"/speaker/25/select" : 0,
						"/speaker/25/aed" : [ 168.989883422851562, 0.0, 4.272644519805908 ],
						"/speaker/25/constraint/circular" : 0,
						"/speaker/25/coordinates/visible" : 1,
						"/speaker/25/proportion" : 100.0,
						"/speaker/25/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/25/image" : "",
						"/speaker/25/label" : "25",
						"/speaker/25/label/visible" : 1,
						"/speaker/25/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/25/label/justification" : "centred",
						"/speaker/25/vumeter/visible" : 0,
						"/speaker/25/vumeter/level" : -60.0,
						"/speaker/26/visible" : 0,
						"/speaker/26/editable" : 0,
						"/speaker/26/select" : 0,
						"/speaker/26/aed" : [ -180.0, 0.0, 4.228000164031982 ],
						"/speaker/26/constraint/circular" : 0,
						"/speaker/26/coordinates/visible" : 1,
						"/speaker/26/proportion" : 100.0,
						"/speaker/26/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/26/image" : "",
						"/speaker/26/label" : "26",
						"/speaker/26/label/visible" : 1,
						"/speaker/26/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/26/label/justification" : "centred",
						"/speaker/26/vumeter/visible" : 0,
						"/speaker/26/vumeter/level" : -60.0,
						"/speaker/27/visible" : 0,
						"/speaker/27/editable" : 0,
						"/speaker/27/select" : 0,
						"/speaker/27/aed" : [ -168.989883422851562, 0.0, 4.272644519805908 ],
						"/speaker/27/constraint/circular" : 0,
						"/speaker/27/coordinates/visible" : 1,
						"/speaker/27/proportion" : 100.0,
						"/speaker/27/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/27/image" : "",
						"/speaker/27/label" : "27",
						"/speaker/27/label/visible" : 1,
						"/speaker/27/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/27/label/justification" : "centred",
						"/speaker/27/vumeter/visible" : 0,
						"/speaker/27/vumeter/level" : -60.0,
						"/speaker/28/visible" : 0,
						"/speaker/28/editable" : 0,
						"/speaker/28/select" : 0,
						"/speaker/28/aed" : [ -158.324264526367188, 0.0, 4.402289867401123 ],
						"/speaker/28/constraint/circular" : 0,
						"/speaker/28/coordinates/visible" : 1,
						"/speaker/28/proportion" : 100.0,
						"/speaker/28/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/28/image" : "",
						"/speaker/28/label" : "28",
						"/speaker/28/label/visible" : 1,
						"/speaker/28/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/28/label/justification" : "centred",
						"/speaker/28/vumeter/visible" : 0,
						"/speaker/28/vumeter/level" : -60.0,
						"/speaker/29/visible" : 0,
						"/speaker/29/editable" : 0,
						"/speaker/29/select" : 0,
						"/speaker/29/aed" : [ -148.275238037109375, 0.0, 4.609774112701416 ],
						"/speaker/29/constraint/circular" : 0,
						"/speaker/29/coordinates/visible" : 1,
						"/speaker/29/proportion" : 100.0,
						"/speaker/29/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/29/image" : "",
						"/speaker/29/label" : "29",
						"/speaker/29/label/visible" : 1,
						"/speaker/29/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/29/label/justification" : "centred",
						"/speaker/29/vumeter/visible" : 0,
						"/speaker/29/vumeter/level" : -60.0,
						"/speaker/30/visible" : 0,
						"/speaker/30/editable" : 0,
						"/speaker/30/select" : 0,
						"/speaker/30/aed" : [ -138.968582153320312, 0.0, 4.883676052093506 ],
						"/speaker/30/constraint/circular" : 0,
						"/speaker/30/coordinates/visible" : 1,
						"/speaker/30/proportion" : 100.0,
						"/speaker/30/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/30/image" : "",
						"/speaker/30/label" : "30",
						"/speaker/30/label/visible" : 1,
						"/speaker/30/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/30/label/justification" : "centred",
						"/speaker/30/vumeter/visible" : 0,
						"/speaker/30/vumeter/level" : -60.0,
						"/speaker/31/visible" : 0,
						"/speaker/31/editable" : 0,
						"/speaker/31/select" : 0,
						"/speaker/31/aed" : [ -130.470108032226562, 0.0, 5.210683345794678 ],
						"/speaker/31/constraint/circular" : 0,
						"/speaker/31/coordinates/visible" : 1,
						"/speaker/31/proportion" : 100.0,
						"/speaker/31/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/31/image" : "",
						"/speaker/31/label" : "31",
						"/speaker/31/label/visible" : 1,
						"/speaker/31/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/31/label/justification" : "centred",
						"/speaker/31/vumeter/visible" : 0,
						"/speaker/31/vumeter/level" : -60.0,
						"/speaker/32/visible" : 0,
						"/speaker/32/editable" : 0,
						"/speaker/32/select" : 0,
						"/speaker/32/aed" : [ -122.724739074707031, 0.0, 5.580798625946045 ],
						"/speaker/32/constraint/circular" : 0,
						"/speaker/32/coordinates/visible" : 1,
						"/speaker/32/proportion" : 100.0,
						"/speaker/32/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/32/image" : "",
						"/speaker/32/label" : "32",
						"/speaker/32/label/visible" : 1,
						"/speaker/32/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/32/label/justification" : "centred",
						"/speaker/32/vumeter/visible" : 0,
						"/speaker/32/vumeter/level" : -60.0,
						"/speaker/33/visible" : 0,
						"/speaker/33/editable" : 0,
						"/speaker/33/select" : 0,
						"/speaker/33/aed" : [ -115.682792663574219, 0.0, 5.983085632324219 ],
						"/speaker/33/constraint/circular" : 0,
						"/speaker/33/coordinates/visible" : 1,
						"/speaker/33/proportion" : 100.0,
						"/speaker/33/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/33/image" : "",
						"/speaker/33/label" : "33",
						"/speaker/33/label/visible" : 1,
						"/speaker/33/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/33/label/justification" : "centred",
						"/speaker/33/vumeter/visible" : 0,
						"/speaker/33/vumeter/level" : -60.0,
						"/speaker/34/visible" : 0,
						"/speaker/34/editable" : 0,
						"/speaker/34/select" : 0,
						"/speaker/34/aed" : [ -109.189651489257812, 0.0, 6.410176753997803 ],
						"/speaker/34/constraint/circular" : 0,
						"/speaker/34/coordinates/visible" : 1,
						"/speaker/34/proportion" : 100.0,
						"/speaker/34/color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/speaker/34/image" : "",
						"/speaker/34/label" : "34",
						"/speaker/34/label/visible" : 1,
						"/speaker/34/label/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/speaker/34/label/justification" : "centred",
						"/speaker/34/vumeter/visible" : 0,
						"/speaker/34/vumeter/level" : -60.0,
						"/stereo/number" : 0,
						"/subwoofer/number" : 0,
						"/listener/visible" : 1,
						"/listener/editable" : 0,
						"/listener/select" : 0,
						"/listener/aed" : [ 90.0, 0.0, 0.0 ],
						"/listener/constraint/circular" : 0,
						"/listener/coordinates/visible" : 1,
						"/listener/orientation/mode" : "default",
						"/listener/orientation" : [ 0.0, 0.0, 0.0, 1.0 ],
						"/listener/lookat/aed" : [ 90.0, 0.0, 0.0 ],
						"/listener/proportion" : 100.0,
						"/listener/color" : [ 0.0, 0.0, 0.0, 0.0 ],
						"/listener/headphones/visible" : 0,
						"/multi/number" : 0,
						"/microphone/number" : 0,
						"/eigenmike/number" : 0,
						"/format" : "aed",
						"/background/color" : [ 0.164705887436867, 0.164705887436867, 0.160784319043159, 1.0 ],
						"/backgroundimage/file" : "",
						"/backgroundimage/visible" : 1,
						"/backgroundimage/opacity" : 1.0,
						"/backgroundimage/scale" : 100.0,
						"/backgroundimage/angle" : 0.0,
						"/backgroundimage/offset/xy" : [ 0.0, 0.0 ],
						"/backgroundimage/quality" : "medium",
						"/display/zoom" : 20.152566909790039,
						"/display/offset/xyz" : [ 0.0, 0.0, 0.0 ],
						"/display/zoom/lock" : 0,
						"/axis/visible" : 1,
						"/axis/label/visible" : 1,
						"/axis/origin/visible" : 1,
						"/axis/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/axis/thickness" : 2.0,
						"/grid/visible" : 1,
						"/grid/mode" : "circular",
						"/grid/spacing" : 1.0,
						"/grid/line/number" : 5,
						"/grid/angulardivisions/number" : 16,
						"/grid/angulardivisions/visible" : 0,
						"/grid/dashed" : 0,
						"/grid/color" : [ 1.0, 1.0, 1.0, 0.501960813999176 ],
						"/grid/thickness" : 1.0,
						"/legend/visible" : 1,
						"/legend/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/legend/unit" : "meters",
						"/emphasis/source" : 1,
						"/emphasis/speaker" : 0,
						"/emphasis/microphone" : 0,
						"/ruler/visible" : 0,
						"/ruler/color" : [ 1.0, 1.0, 1.0, 1.0 ],
						"/ruler/unit" : "meters",
						"/hoa/number" : 0,
						"/anchor/number" : 0,
						"/phone/number" : 0,
						"/area/number" : 0,
						"/speakerhull/visible" : 1,
						"/speakerhull/color" : [ 0.737254917621613, 1.0, 0.61176472902298, 1.0 ],
						"/speakerhull/fill" : 1,
						"/speakerhull/fill/color" : [ 0.372549027204514, 1.0, 0.945098042488098, 0.47843137383461 ],
						"/speakerhull/vertex/number" : 34,
						"/speakerhull/vertext/1/xyz" : [ -6.053999900817871, -2.10699987411499, 0.0 ],
						"/speakerhull/vertext/2/xyz" : [ -5.392000198364258, -2.593000173568726, 0.0 ],
						"/speakerhull/vertext/3/xyz" : [ -4.695000171661377, -3.016999959945679, 0.0 ],
						"/speakerhull/vertext/4/xyz" : [ -3.96399974822998, -3.38200044631958, 0.0 ],
						"/speakerhull/vertext/5/xyz" : [ -3.206000328063965, -3.68399977684021, 0.0 ],
						"/speakerhull/vertext/6/xyz" : [ -2.42400050163269, -3.920999765396118, 0.0 ],
						"/speakerhull/vertext/7/xyz" : [ -1.626000046730042, -4.091000080108643, 0.0 ],
						"/speakerhull/vertext/8/xyz" : [ -0.815999567508698, -4.193999767303467, 0.0 ],
						"/speakerhull/vertext/9/xyz" : [ 0.0, -4.228000164031982, 0.0 ],
						"/speakerhull/vertext/10/xyz" : [ 0.815999567508698, -4.193999767303467, 0.0 ],
						"/speakerhull/vertext/11/xyz" : [ 1.624999761581421, -4.091000080108643, 0.0 ],
						"/speakerhull/vertext/12/xyz" : [ 2.42400050163269, -3.920999765396118, 0.0 ],
						"/speakerhull/vertext/13/xyz" : [ 3.204999208450317, -3.684000253677368, 0.0 ],
						"/speakerhull/vertext/14/xyz" : [ 3.96399974822998, -3.38200044631958, 0.0 ],
						"/speakerhull/vertext/15/xyz" : [ 4.695000171661377, -3.017999887466431, 0.0 ],
						"/speakerhull/vertext/16/xyz" : [ 5.392000198364258, -2.593000173568726, 0.0 ],
						"/speakerhull/vertext/17/xyz" : [ 6.051000118255615, -2.111999988555908, 0.0 ],
						"/speakerhull/vertext/18/xyz" : [ 6.053999900817871, 2.10699987411499, 0.0 ],
						"/speakerhull/vertext/19/xyz" : [ 5.392000198364258, 2.593000173568726, 0.0 ],
						"/speakerhull/vertext/20/xyz" : [ 4.695000171661377, 3.016999959945679, 0.0 ],
						"/speakerhull/vertext/21/xyz" : [ 3.964000225067139, 3.381999969482422, 0.0 ],
						"/speakerhull/vertext/22/xyz" : [ 3.206000089645386, 3.68399977684021, 0.0 ],
						"/speakerhull/vertext/23/xyz" : [ 2.424000024795532, 3.921000003814697, 0.0 ],
						"/speakerhull/vertext/24/xyz" : [ 1.626000046730042, 4.091000080108643, 0.0 ],
						"/speakerhull/vertext/25/xyz" : [ 0.816000044345856, 4.193999767303467, 0.0 ],
						"/speakerhull/vertext/26/xyz" : [ 0.0, 4.228000164031982, 0.0 ],
						"/speakerhull/vertext/27/xyz" : [ -0.816000044345856, 4.193999767303467, 0.0 ],
						"/speakerhull/vertext/28/xyz" : [ -1.625, 4.091000080108643, 0.0 ],
						"/speakerhull/vertext/29/xyz" : [ -2.424000024795532, 3.921000003814697, 0.0 ],
						"/speakerhull/vertext/30/xyz" : [ -3.204999923706055, 3.68399977684021, 0.0 ],
						"/speakerhull/vertext/31/xyz" : [ -3.964000225067139, 3.381999969482422, 0.0 ],
						"/speakerhull/vertext/32/xyz" : [ -4.695000171661377, 3.017999887466431, 0.0 ],
						"/speakerhull/vertext/33/xyz" : [ -5.392000198364258, 2.593000173568726, 0.0 ],
						"/speakerhull/vertext/34/xyz" : [ -6.051000118255615, 2.111999988555908, 0.0 ],
						"/settings/visible" : 0,
						"/settings/editable" : 1,
						"/layout" : "single",
						"/window/title" : "Spat Viewer",
						"/window/visible" : 0,
						"/window/moveable" : 1,
						"/window/resizable" : 1,
						"/window/enable" : 1,
						"/window/bounds" : [ 703, 53, 737, 613 ],
						"/window/background/color" : [ 0.82745099067688, 0.82745099067688, 0.82745099067688, 1.0 ],
						"/window/opaque" : 1,
						"/window/titlebar" : 1,
						"/window/fullscreen" : 0,
						"/window/minimise" : 0,
						"/window/scale" : 100.0,
						"/window/rendering/engine" : "",
						"/window/rendering/fps/visible" : 0,
						"/window/floating" : 1,
						"/window/hidesondeactivate" : 0,
						"/window/buttons/close" : 1,
						"/window/buttons/minimise" : 1,
						"/window/buttons/maximise" : 1,
						"embed" : 1
					}
,
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 274.166666666666629, 737.0, 138.0, 22.0 ],
					"saved_object_attributes" : 					{
						"parameter_enable" : 0
					}
,
					"text" : "spat5.viewer @embed 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-68",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 74.5, 240.0, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 151.5, 59.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-66",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 145.5, 310.0, 111.0, 22.0 ],
					"text" : "/window/floating $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 1,
							"revision" : 11,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 115.0, 162.0, 1145.0, 825.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-46",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1543.0, 86.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-76",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 1492.5, 160.0, 58.0, 22.0 ],
									"text" : "loadbang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-75",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 1594.5, 240.0, 32.0, 22.0 ],
									"text" : "+ 16"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-73",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "int" ],
									"patching_rect" : [ 1513.5, 217.0, 100.0, 22.0 ],
									"text" : "t i i"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-71",
									"linecount" : 3,
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1513.5, 270.0, 100.0, 49.0 ],
									"text" : "sprintf rule /source/%d /source/%d"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-47",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"patching_rect" : [ 1492.5, 190.0, 41.0, 22.0 ],
									"text" : "uzi 64"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-44",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"patching_rect" : [ 1337.0, 569.0, 41.0, 22.0 ],
									"text" : "uzi 16"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-43",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"patching_rect" : [ 1103.0, 451.0, 103.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0
									}
,
									"text" : "spat5.osc.replace"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-41",
									"maxclass" : "spat5.osc.view",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "int", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1413.0, 417.0, 217.0, 301.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-33",
									"linecount" : 5,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1240.0, 431.0, 50.0, 76.0 ],
									"text" : "FullPacket 656 140440817565472"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1018.5, 617.5, 57.0, 22.0 ],
									"text" : "tosymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-35",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 997.0, 451.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-29",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "int" ],
									"patching_rect" : [ 1008.0, 543.0, 29.5, 22.0 ],
									"text" : "t i i"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 832.763158999999973, 692.0, 306.000000000000114, 22.0 ],
									"text" : "join 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 842.763158999999973, 661.0, 203.0, 22.0 ],
									"text" : "combine /source/ i /label @triggers 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"patching_rect" : [ 970.0, 496.0, 41.0, 22.0 ],
									"text" : "uzi 16"
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-31",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 145.0, 512.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-21",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 274.0, 653.0, 130.0, 22.0 ],
									"text" : "/source/*/proportion $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 340.0, 413.0, 149.0, 22.0 ],
									"text" : "/source/*/vumeter/visible 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 850.0, 10.5, 838.0, 22.0 ],
									"text" : "\"OWC Aura Pro SSD:/Users/psch/_GitHub/seamless/speakerpositions/HUFO/Hufo_WFS_polygon.txt\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "dropfile",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 756.0, -8.0, 33.0, 42.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1406.0, 132.0, 29.5, 22.0 ],
									"text" : "16"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-42",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 878.0, 547.0, 69.0, 22.0 ],
									"text" : "/format aed"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-40",
									"linecount" : 4,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 274.0, 22.5, 50.0, 62.0 ],
									"text" : "0.735569 1. 0.612964 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-39",
									"linecount" : 4,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 471.0, 40.0, 50.0, 62.0 ],
									"text" : "0.374111 1. 0.944332 0.48"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"linecount" : 5,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 660.0, 243.0, 50.0, 76.0 ],
									"text" : "0.165051 0.166 0.161604 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-36",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 214.5, 413.0, 79.0, 22.0 ],
									"text" : "/layout single"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-34",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 946.0, 60.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-32",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1103.0, 67.0, 29.5, 22.0 ],
									"text" : "1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-30",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 862.0, 338.0, 67.0, 22.0 ],
									"text" : "/format xyz"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 91.0, 413.0, 29.0, 22.0 ],
									"text" : "thru"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-120",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 8,
											"minor" : 1,
											"revision" : 11,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"classnamespace" : "box",
										"rect" : [ 0.0, 0.0, 640.0, 480.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"assistshowspatchername" : 0,
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-118",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 104.5, 423.0, 232.0, 22.0 ],
													"text" : "write ~/Desktop/spat2swsColor.SWSColor"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-116",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"patching_rect" : [ 283.0, 339.0, 32.0, 22.0 ],
													"text" : "t b b"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-115",
													"linecount" : 2,
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 296.0, 386.0, 138.0, 35.0 ],
													"text" : "gradientEnd=0, cr, gradientStart=16449549"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-110",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 96.0, 326.0, 126.0, 22.0 ],
													"text" : "sprintf custcolor%i=%i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-109",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 119.5, 294.0, 37.0, 22.0 ],
													"text" : "join 2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-108",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 137.5, 231.0, 55.0, 22.0 ],
													"text" : "$3 $4 $5"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-106",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 1,
															"revision" : 11,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 59.0, 104.0, 640.0, 480.0 ],
														"bglocked" : 0,
														"openinpresentation" : 0,
														"default_fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"gridonopen" : 1,
														"gridsize" : [ 15.0, 15.0 ],
														"gridsnaponopen" : 1,
														"objectsnaponopen" : 1,
														"statusbarvisible" : 2,
														"toolbarvisible" : 1,
														"lefttoolbarpinned" : 0,
														"toptoolbarpinned" : 0,
														"righttoolbarpinned" : 0,
														"bottomtoolbarpinned" : 0,
														"toolbars_unpinned_last_save" : 0,
														"tallnewobj" : 0,
														"boxanimatetime" : 200,
														"enablehscroll" : 1,
														"enablevscroll" : 1,
														"devicewidth" : 0.0,
														"description" : "",
														"digest" : "",
														"tags" : "",
														"style" : "",
														"subpatcher_template" : "",
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"id" : "obj-4",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 65.0, 137.5, 57.0, 22.0 ],
																	"text" : "vexpr $i1"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-3",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 65.0, 91.0, 93.0, 22.0 ],
																	"text" : "vexpr $f1 * 255."
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-2",
																	"index" : 1,
																	"maxclass" : "outlet",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 65.0, 330.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-1",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 65.0, 44.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-101",
																	"maxclass" : "newobj",
																	"numinlets" : 3,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 65.0, 279.0, 117.0, 22.0 ],
																	"text" : "vexpr $i1 + $i2 + $i3"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-102",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 4,
																	"outlettype" : [ "", "", "", "" ],
																	"patching_rect" : [ 65.0, 184.0, 51.0, 22.0 ],
																	"text" : "unjoin 3"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-103",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "int" ],
																	"patching_rect" : [ 163.0, 248.0, 33.0, 22.0 ],
																	"text" : "<< 0"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-104",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "int" ],
																	"patching_rect" : [ 114.0, 248.0, 33.0, 22.0 ],
																	"text" : "<< 8"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-105",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "int" ],
																	"patching_rect" : [ 65.0, 248.0, 39.0, 22.0 ],
																	"text" : "<< 16"
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-3", 0 ],
																	"source" : [ "obj-1", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-2", 0 ],
																	"source" : [ "obj-101", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-103", 0 ],
																	"source" : [ "obj-102", 2 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-104", 0 ],
																	"source" : [ "obj-102", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-105", 0 ],
																	"source" : [ "obj-102", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-101", 2 ],
																	"source" : [ "obj-103", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-101", 1 ],
																	"source" : [ "obj-104", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-101", 0 ],
																	"source" : [ "obj-105", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-4", 0 ],
																	"source" : [ "obj-3", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-102", 0 ],
																	"source" : [ "obj-4", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 137.5, 260.0, 55.0, 22.0 ],
													"saved_object_attributes" : 													{
														"description" : "",
														"digest" : "",
														"globalpatchername" : "",
														"tags" : ""
													}
,
													"text" : "p rgb2int"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-100",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 104.5, 260.0, 29.5, 22.0 ],
													"text" : "$1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-98",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 195.0, 189.0, 91.0, 22.0 ],
													"text" : "[SWS Color], cr"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-96",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"patching_rect" : [ 195.0, 147.0, 32.0, 22.0 ],
													"text" : "t b b"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-95",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "cr", "", "" ],
													"patching_rect" : [ 54.0, 210.0, 40.0, 22.0 ],
													"text" : "t cr l l"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-94",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 307.0, 189.0, 35.0, 22.0 ],
													"text" : "clear"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-92",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "", "bang" ],
													"patching_rect" : [ 124.0, 100.0, 40.0, 22.0 ],
													"text" : "t b l b"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-91",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 54.0, 184.0, 117.0, 22.0 ],
													"saved_object_attributes" : 													{
														"parameter_enable" : 0,
														"parameter_mappable" : 0
													}
,
													"text" : "spat5.osc.unslashify"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-90",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 50.0, 156.0, 80.0, 22.0 ],
													"saved_object_attributes" : 													{
														"parameter_enable" : 0,
														"parameter_mappable" : 0
													}
,
													"text" : "spat5.osc.iter"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-86",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "bang", "int" ],
													"patching_rect" : [ 261.0, 461.0, 81.0, 22.0 ],
													"text" : "text swsColor"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-119",
													"index" : 1,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 124.0, 40.0, 30.0, 30.0 ]
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-109", 0 ],
													"source" : [ "obj-100", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-109", 1 ],
													"source" : [ "obj-106", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-106", 0 ],
													"source" : [ "obj-108", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-110", 0 ],
													"source" : [ "obj-109", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-86", 0 ],
													"source" : [ "obj-110", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-86", 0 ],
													"source" : [ "obj-115", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-115", 0 ],
													"source" : [ "obj-116", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-118", 0 ],
													"source" : [ "obj-116", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-86", 0 ],
													"source" : [ "obj-118", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-92", 0 ],
													"source" : [ "obj-119", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-91", 0 ],
													"source" : [ "obj-90", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-95", 0 ],
													"source" : [ "obj-91", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-116", 0 ],
													"source" : [ "obj-92", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-90", 0 ],
													"source" : [ "obj-92", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 0 ],
													"source" : [ "obj-92", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-86", 0 ],
													"source" : [ "obj-94", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-100", 0 ],
													"source" : [ "obj-95", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-108", 0 ],
													"source" : [ "obj-95", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-86", 0 ],
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"source" : [ "obj-96", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-98", 0 ],
													"source" : [ "obj-96", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-86", 0 ],
													"source" : [ "obj-98", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 1376.0, 347.0, 115.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"tags" : ""
									}
,
									"text" : "p writeSwsColorFIle"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-89",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1400.0, 72.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-22",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 1158.0, 172.0, 29.5, 22.0 ],
									"text" : "t b l"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 1092.0, 374.0, 150.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.osc.prepend /source"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 11.0,
									"id" : "obj-14",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1086.0, 132.0, 74.0, 21.0 ],
									"text" : "/colormap $1"
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-13",
									"lockeddragscroll" : 0,
									"maxclass" : "bpatcher",
									"name" : "spat5.known.colormaps.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "" ],
									"patching_rect" : [ 1086.0, 107.5, 80.0, 20.0 ],
									"varname" : "live.menu[3]",
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bubble" : 1,
									"bubbleside" : 2,
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-23",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 1225.5, 92.0, 105.0, 50.0 ],
									"text" : "generates a list of N contrasted colors",
									"textjustification" : 1
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-24",
									"maxclass" : "number",
									"minimum" : 0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1244.0, 142.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-25",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1244.0, 172.0, 106.0, 21.0 ],
									"text" : "prepend /contrasted"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-26",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 1188.5, 293.0, 91.0, 22.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0,
										"parameter_mappable" : 0
									}
,
									"text" : "spat5.colormap"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 727.0, 338.0, 109.0, 22.0 ],
									"text" : "/source/number 32"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-15",
									"index" : 2,
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 522.0, 718.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-27",
									"lockeddragscroll" : 0,
									"maxclass" : "bpatcher",
									"name" : "spat5.known.colors.maxpat",
									"numinlets" : 1,
									"numoutlets" : 2,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 546.0, 293.0, 85.5, 15.0 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-201",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 526.0, 333.0, 139.0, 21.0 ],
									"text" : "prepend /background/color"
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-198",
									"lockeddragscroll" : 0,
									"maxclass" : "bpatcher",
									"name" : "spat5.colorpicker.maxpat",
									"numinlets" : 0,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "list" ],
									"patching_rect" : [ 526.0, 263.0, 40.0, 20.0 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "toggle",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 443.0, 282.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-10",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 389.5, 328.5, 107.0, 21.0 ],
									"text" : "/speaker/*/visible $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 660.0, 140.0, 115.0, 22.0 ],
									"text" : "/speaker/number 34"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 8,
											"minor" : 1,
											"revision" : 11,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"classnamespace" : "box",
										"rect" : [ 59.0, 104.0, 755.0, 663.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"assistshowspatchername" : 0,
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-10",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 481.0, 454.0, 123.0, 22.0 ],
													"text" : "prepend /speakers/xy"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-9",
													"linecount" : 12,
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 444.0, 225.294495105743408, 219.0, 169.0 ],
													"text" : "-6.051 2.112 -5.392 2.593 -4.695 3.018 -3.964 3.382 -3.205 3.684 -2.424 3.921 -1.625 4.091 -0.816 4.194 0. 4.228 0.816 4.194 1.626 4.091 2.424 3.921 3.206 3.684 3.964 3.382 4.695 3.017 5.392 2.593 6.054 2.107 6.051 -2.112 5.392 -2.593 4.695 -3.018 3.964 -3.382 3.205 -3.684 2.424 -3.921 1.625 -4.091 0.816 -4.194 0. -4.228 -0.816 -4.194 -1.626 -4.091 -2.424 -3.921 -3.206 -3.684 -3.964 -3.382 -4.695 -3.017 -5.392 -2.593 -6.054 -2.107"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-6",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 220.447366952896118, 536.0, 51.0, 22.0 ],
													"text" : "zl.group"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-7",
													"index" : 2,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 405.0, 39.999999679687498, 30.0, 30.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "int" ],
													"patching_rect" : [ 275.0, 247.0, 29.5, 22.0 ],
													"text" : "t b i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "button",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 127.236841201782227, 157.1365966796875, 24.0, 24.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-80",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 220.447366952896118, 441.978717565536499, 39.0, 22.0 ],
													"text" : "$2 $3"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-74",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 86.236841201782227, 374.662926435470581, 29.5, 22.0 ],
													"text" : "$1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-54",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 111.5, 361.399767637252808, 29.5, 22.0 ],
													"text" : "t l l"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-48",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 353.526322603225708, 316.768181800842285, 29.5, 22.0 ],
													"text" : "+ 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-47",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 34.0, 489.136613845825195, 37.0, 22.0 ],
													"text" : "join 2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-46",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 85.078948497772217, 441.978717565536499, 123.0, 22.0 ],
													"text" : "sprintf /speaker/%i/xy"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-45",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 106.447366952896118, 337.399767637252808, 55.0, 22.0 ],
													"text" : "zl.slice 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-40",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 252.500003576278687, 338.768181800842285, 44.0, 22.0 ],
													"text" : "line $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-33",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 306.184216022491455, 260.031338453292847, 29.5, 22.0 ],
													"text" : "- 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-31",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "bang", "int" ],
													"patching_rect" : [ 321.526322603225708, 294.768181800842285, 51.0, 22.0 ],
													"text" : "uzi 35 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-29",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 180.500002145767212, 114.1365966796875, 39.0, 22.0 ],
													"text" : "query"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-26",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 354.447366952896118, 225.294495105743408, 50.0, 22.0 ],
													"text" : "35"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-15",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "bang", "int" ],
													"patching_rect" : [ 261.973688125610352, 201.083967924118042, 40.0, 22.0 ],
													"text" : "text"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-4",
													"index" : 1,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 261.973657201782203, 39.999999679687498, 30.0, 30.0 ]
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-5",
													"index" : 1,
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 34.00002520178225, 571.136627679687535, 30.0, 30.0 ]
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 0 ],
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-33", 0 ],
													"source" : [ "obj-1", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"source" : [ "obj-10", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 0 ],
													"order" : 1,
													"source" : [ "obj-15", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-26", 1 ],
													"order" : 0,
													"source" : [ "obj-15", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-29", 0 ],
													"source" : [ "obj-15", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 0 ],
													"source" : [ "obj-15", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 1 ],
													"source" : [ "obj-26", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"source" : [ "obj-29", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-48", 0 ],
													"source" : [ "obj-31", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"source" : [ "obj-31", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 1 ],
													"source" : [ "obj-33", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"source" : [ "obj-40", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-54", 0 ],
													"source" : [ "obj-45", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-47", 0 ],
													"source" : [ "obj-46", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"source" : [ "obj-47", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-40", 0 ],
													"source" : [ "obj-48", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-74", 0 ],
													"source" : [ "obj-54", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-80", 0 ],
													"source" : [ "obj-54", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 1 ],
													"source" : [ "obj-6", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-46", 0 ],
													"source" : [ "obj-74", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-47", 1 ],
													"order" : 1,
													"source" : [ "obj-80", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"order" : 0,
													"source" : [ "obj-80", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"source" : [ "obj-9", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 832.763158999999973, 120.863403000000005, 151.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"tags" : ""
									}
,
									"text" : "p loadSpeakerCoordinates"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 862.0, 47.0, 49.0, 22.0 ],
									"text" : "read $1"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-1",
									"index" : 1,
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 90.0, 718.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-85",
									"lockeddragscroll" : 0,
									"maxclass" : "bpatcher",
									"name" : "spat5.known.colors.maxpat",
									"numinlets" : 1,
									"numoutlets" : 2,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 204.0, 100.5, 85.5, 15.0 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-88",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 444.0, 126.5, 154.0, 21.0 ],
									"text" : "prepend /speakerhull/fill/color"
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-91",
									"lockeddragscroll" : 0,
									"maxclass" : "bpatcher",
									"name" : "spat5.colorpicker.maxpat",
									"numinlets" : 0,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "list" ],
									"patching_rect" : [ 443.0, 10.5, 40.0, 20.0 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-92",
									"maxclass" : "live.toggle",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 334.5, 106.5, 15.0, 15.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_enum" : [ "off", "on" ],
											"parameter_longname" : "live.toggle[193]",
											"parameter_mmax" : 1,
											"parameter_shortname" : "live.toggle[1]",
											"parameter_type" : 2
										}

									}
,
									"varname" : "live.toggle[1]"
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-9",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 334.0, 126.5, 97.0, 21.0 ],
									"text" : "/speakerhull/fill $1"
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-94",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 184.0, 126.5, 140.0, 21.0 ],
									"text" : "prepend /speakerhull/color"
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-95",
									"lockeddragscroll" : 0,
									"maxclass" : "bpatcher",
									"name" : "spat5.colorpicker.maxpat",
									"numinlets" : 0,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "list" ],
									"patching_rect" : [ 184.0, 10.5, 40.0, 20.0 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-96",
									"maxclass" : "live.text",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 56.0, 106.5, 44.0, 15.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_enum" : [ "val1", "val2" ],
											"parameter_longname" : "live.toggle[291]",
											"parameter_mmax" : 1,
											"parameter_shortname" : "live.toggle[1]",
											"parameter_type" : 2
										}

									}
,
									"text" : "visible",
									"texton" : "visible",
									"varname" : "live.toggle[4]"
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 11.0,
									"id" : "obj-97",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 56.0, 126.5, 119.0, 21.0 ],
									"text" : "/speakerhull/visible $1"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"source" : [ "obj-13", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"source" : [ "obj-18", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"order" : 2,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"order" : 0,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"order" : 1,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-201", 0 ],
									"order" : 1,
									"source" : [ "obj-198", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 1 ],
									"order" : 0,
									"source" : [ "obj-198", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"source" : [ "obj-2", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"order" : 0,
									"source" : [ "obj-201", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"order" : 1,
									"source" : [ "obj-201", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"source" : [ "obj-22", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-24", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"midpoints" : [ 1253.5, 212.0, 1198.0, 212.0 ],
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-120", 0 ],
									"order" : 0,
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-33", 1 ],
									"order" : 1,
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"order" : 2,
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-201", 0 ],
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 1 ],
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"source" : [ "obj-29", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-30", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-32", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 1 ],
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-35", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 1 ],
									"source" : [ "obj-37", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-201", 0 ],
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-88", 0 ],
									"source" : [ "obj-39", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 1 ],
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-94", 0 ],
									"source" : [ "obj-40", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"order" : 1,
									"source" : [ "obj-43", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"order" : 0,
									"source" : [ "obj-43", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-76", 0 ],
									"source" : [ "obj-46", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-73", 0 ],
									"source" : [ "obj-47", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-41", 0 ],
									"order" : 0,
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-43", 0 ],
									"order" : 1,
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-43", 0 ],
									"source" : [ "obj-71", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-71", 0 ],
									"source" : [ "obj-73", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-75", 0 ],
									"source" : [ "obj-73", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-71", 1 ],
									"source" : [ "obj-75", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-47", 0 ],
									"source" : [ "obj-76", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-94", 0 ],
									"source" : [ "obj-85", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-88", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-89", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-9", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 1 ],
									"order" : 0,
									"source" : [ "obj-91", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-88", 0 ],
									"order" : 1,
									"source" : [ "obj-91", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"source" : [ "obj-92", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-94", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-40", 1 ],
									"order" : 0,
									"source" : [ "obj-95", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-94", 0 ],
									"order" : 1,
									"source" : [ "obj-95", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-97", 0 ],
									"source" : [ "obj-96", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-97", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "AudioStatus_Menu",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "color",
										"color" : [ 0.294118, 0.313726, 0.337255, 1 ],
										"color1" : [ 0.454902, 0.462745, 0.482353, 0.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "Default 11Bold Poletti",
								"default" : 								{
									"fontsize" : [ 11.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "Default M4L",
								"default" : 								{
									"fontsize" : [ 11.0 ],
									"patchlinecolor" : [ 0.290196, 0.309804, 0.301961, 0.85 ],
									"fontname" : [ "Arial Bold" ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "Default M4L Poletti",
								"default" : 								{
									"fontsize" : [ 10.0 ],
									"patchlinecolor" : [ 0.290196, 0.309804, 0.301961, 0.85 ],
									"fontname" : [ "Arial Bold" ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "Default M4L-1",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.376471, 0.384314, 0.4, 1.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39
									}
,
									"fontsize" : [ 11.0 ],
									"fontname" : [ "Arial" ],
									"fontface" : [ 1 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "Default Max7 Poletti",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.376471, 0.384314, 0.4, 1.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39
									}

								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "jbb",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.376471, 0.384314, 0.4, 1.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39
									}
,
									"fontsize" : [ 9.0 ],
									"fontname" : [ "Arial" ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "ksliderWhite",
								"default" : 								{
									"color" : [ 1.0, 1.0, 1.0, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "newobjBlue-1",
								"default" : 								{
									"accentcolor" : [ 0.317647, 0.654902, 0.976471, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "newobjGreen-1",
								"default" : 								{
									"accentcolor" : [ 0.0, 0.533333, 0.168627, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "numberGold-1",
								"default" : 								{
									"accentcolor" : [ 0.764706, 0.592157, 0.101961, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 304.5, 98.0, 88.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p viewerConfig",
					"varname" : "viewerConfig"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-41", 0 ],
					"source" : [ "obj-109", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 0 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"source" : [ "obj-13", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-136", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 1 ],
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"source" : [ "obj-143", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-143", 0 ],
					"source" : [ "obj-145", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-17", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 0 ],
					"source" : [ "obj-18", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-23", 1 ],
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"source" : [ "obj-2", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"order" : 0,
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"midpoints" : [ 314.0, 318.0, 351.0, 318.0, 351.0, 374.0, 283.666666666666629, 374.0 ],
					"order" : 1,
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-29", 0 ],
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-29", 0 ],
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-23", 0 ],
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-116", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"source" : [ "obj-30", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-30", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-32", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-109", 2 ],
					"source" : [ "obj-34", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-109", 2 ],
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-38", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-40", 0 ],
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"source" : [ "obj-40", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-37", 0 ],
					"source" : [ "obj-40", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-109", 1 ],
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-46", 0 ],
					"source" : [ "obj-44", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-47", 0 ],
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-44", 0 ],
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"source" : [ "obj-46", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-66", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-66", 0 ],
					"source" : [ "obj-68", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"order" : 1,
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-109", 0 ],
					"order" : 0,
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"order" : 2,
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"parameters" : 		{
			"obj-2::obj-13::obj-10" : [ "live.menu[3]", "live.menu[1]", 0 ],
			"obj-2::obj-198::obj-62" : [ "live.text[2]", "live.text[9]", 0 ],
			"obj-2::obj-27::obj-10" : [ "live.menu[2]", "live.menu[1]", 0 ],
			"obj-2::obj-85::obj-10" : [ "live.menu[1]", "live.menu[1]", 0 ],
			"obj-2::obj-91::obj-62" : [ "live.text[1]", "live.text[9]", 0 ],
			"obj-2::obj-92" : [ "live.toggle[193]", "live.toggle[1]", 0 ],
			"obj-2::obj-95::obj-62" : [ "live.text[12]", "live.text[9]", 0 ],
			"obj-2::obj-96" : [ "live.toggle[291]", "live.toggle[1]", 0 ],
			"parameterbanks" : 			{

			}
,
			"parameter_overrides" : 			{
				"obj-2::obj-13::obj-10" : 				{
					"parameter_longname" : "live.menu[3]"
				}
,
				"obj-2::obj-198::obj-62" : 				{
					"parameter_longname" : "live.text[2]"
				}
,
				"obj-2::obj-27::obj-10" : 				{
					"parameter_longname" : "live.menu[2]"
				}
,
				"obj-2::obj-91::obj-62" : 				{
					"parameter_longname" : "live.text[1]"
				}

			}
,
			"inherited_shortname" : 1
		}
,
		"dependency_cache" : [ 			{
				"name" : "spat5.colorpicker.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/spat5/patchers",
				"patcherrelativepath" : "../../../../Documents/Max 8/Packages/spat5/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "spat5.known.colors.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/spat5/patchers",
				"patcherrelativepath" : "../../../../Documents/Max 8/Packages/spat5/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "spat5.known.colormaps.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/spat5/patchers",
				"patcherrelativepath" : "../../../../Documents/Max 8/Packages/spat5/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "thru.maxpat",
				"bootpath" : "C74:/patchers/m4l/Pluggo for Live resources/patches",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "ps-packageCounter.maxpat",
				"bootpath" : "~/Documents/Max 8/Library/ps-maxTools/ps-oscTools",
				"patcherrelativepath" : "../../../../Documents/Max 8/Library/ps-maxTools/ps-oscTools",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "spat5.colormap.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.prepend.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.iter.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.unslashify.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.view.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.replace.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.viewer.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.routepass.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.viewer.control.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.trim.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.append.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.route.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "spat5.osc.flip.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
